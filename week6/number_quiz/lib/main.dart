import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quiz = ""; // 보여줄 퀴즈를 담을 변수

  @override
  // StatefulWidget에서 위젯이 생성 시 호출되는 함수
  void initState() {
    super.initState(); // 부모 위젯의 initState()를 호출
    print("시작");
    getQuiz(); // 퀴즈 가져오기 호출
  }

  /// 퀴즈 가져오기 - getQuiz 함수
  void getQuiz() async {
    /// New Quiz 클릭시 API 호출 결과 가져와 quiz 변수에 할당
    // getNumberTrivia()를 동기적으로 실행 - async, await
    String trivia = await getNumberTrivia(); // Future<String> 반환
    setState(() {
      // 화면 갱신 필요하므로 setState()로 감싸기 - 가져온 결과를 quiz에 할당
      quiz = trivia;
    });
  }

  /// Numbers API 호출하기 - "New Quiz" 버튼 클릭 시 API 호출
  // HTTP 요청은 언제나 비동기로 작동 - async와 await 추가
  Future<String> getNumberTrivia() async {
    // get 메소드로 URL 호출
    Response result = await Dio().get('http://numbersapi.com/random/trivia');
    String trivia = result.data; // 응답 결과 가져오기
    print(trivia);
    return trivia; // API 호출해 얻은 결과(퀴즈) 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent, // 배경 색상으로 화면 전체 채우기
      body: SafeArea(
        // SafeArea 위젯: 기기별 화면 영역에 맞추어 여백 생성
        child: Container(
          padding: const EdgeInsets.all(16),
          // color: Colors.pinkAccent, - 컨테이너 내부만 핑크 컬러로
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // quiz
              Expanded(
                child: Center(
                  child: Text(
                    quiz, // 퀴즈를 화면에 보여주도록 함
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // New Quiz 버튼
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  child: Text(
                    "New Quiz",
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 24,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    // New Quiz 클릭 시 퀴즈 가져오기
                    getQuiz();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
