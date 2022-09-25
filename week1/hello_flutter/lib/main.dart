import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home - 화면에 보이는 영역 (Scaffold 위젯 사용 중)
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true, // 안드로이드에서 title 중앙 정렬
          title: Text(
            // Text 위젯이 Column 위젯의 children 속성으로 들어감
            "Hello Flutter",
            style: TextStyle(fontSize: 28),
          ),
        ), // appBar - 상단 바

        // body - 화면 중앙 가장 큰 면적
        // padding을 scroll 위젯으로 감싸주어 해당 페이지 스크롤 가능케 함
        body: SingleChildScrollView(
          child: Padding(
            // Padding - column 위젯에 여백 추가
            padding: const EdgeInsets.all(16), // 전방위 여백 추가
            child: Column(
              // column - 세로 방향으로 여러 위젯을 나열
              children: [
                // 사진이 크면 overload 발생 - SingleChildScrollView 사용
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                    "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                    width: 81,
                  ),
                ),
                TextField(
                  // textField - 텍스트 입력 칸 생성
                  decoration: InputDecoration(
                    labelText: "이메일",
                  ),
                ),
                TextField(
                  obscureText: true, // 비밀번호 안 보이게 하는 보안 속성
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                  ),
                ),
                Container(
                  // ElavatedButton 자체에 width 속성이 없어 사용
                  // 부모 위젯인 container 속성을 사용해 조절 가능
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("로그인"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
