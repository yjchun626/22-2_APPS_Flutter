import 'package:flutter/cupertino.dart';
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

/// 버킷 클래스
class Bucket {
  String job; // 할 일
  bool isDone; // 완료 여부

  Bucket(this.job, this.isDone); // 생성자
}

/// 홈 페이지
/// HomePage는 "버킷 리스트 유무"라는 상태에 따라 다른 화면 갱신해야 함
/// 따라서 StatefulWidget으로 변경
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// HomePage의 상태를 관리하는 _HomePageState
class _HomePageState extends State<HomePage> {
  // 버킷 리스트 가지고 있을 상태 변수 bucktetList
  // bucketList 타입이 List<Bucket>이므로 bucketList[index]의 타입은 Bucket
  List<Bucket> bucketList = []; // 전체 버킷리스트 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷 리스트"),
      ),
      body: bucketList.isEmpty
          // bucketList에 항목이 하나라도 있다면 body에 해당 항목이 보여지게 함
          ? Center(child: Text("버킷 리스트를 작성해 주세요."))
          : ListView.builder(
              itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
              itemBuilder: (context, index) {
                Bucket bucket = bucketList[index]; // index에 해당하는 bucket 가져오기
                return ListTile(
                  // 버킷 리스트 할 일
                  title: Text(
                    bucket.job,
                    style: TextStyle(
                      fontSize: 24,
                      color: bucket.isDone ? Colors.grey : Colors.black,
                      decoration: bucket.isDone
                          ? TextDecoration.lineThrough // 텍스트 중앙 선
                          : TextDecoration.none,
                    ),
                  ),
                  // 삭제 아이콘 버튼
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.delete),
                    onPressed: () {
                      // 삭제 버튼 클릭시
                      showDeleteDialog(context, index);
                    },
                  ),
                  onTap: () {
                    // 아이템 클릭시
                    setState(() {
                      bucket.isDone = !bucket.isDone; // isDone 상태 변경
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // await 사용하려면 해당 함수에 async 키워드 넣음
          // await는 Navigator.push()로 화면 띄운 뒤, 해당 화면이 종료될 때까지 await가 있는 라인에서 기다리도록 만들어 줌
          // 이후 화면이 종료되면 job이라는 변수에 반환된 파라미터를 할당 후 밑의 if절이 실행됨

          // + 버튼 클릭시 버킷 생성 페이지로 이동
          String? job = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );
          if (job != null) {
            // job이 null 아닌 경우(값이 있을때) bucketList에 추가하도록 if문으로 감싸줌
            setState(() {
              // bucketList에 전달 받은 job을 추가한 뒤 화면 갱신하기 위해 setState()로 감싸줌
              // CreatePage로 받은 job을 Bucket 클래스의 생성자에 전달 후,
              // 인스턴스를 BucketList에 추가해줌
              Bucket newBucket = Bucket(job, false); // isDone(완료 여부) 기본값 false
              bucketList.add(newBucket); // 버킷 리스트에 추가
            });
          }
        },
      ),
    );
  }

  // 리팩터링 - showDeleteDialog 함수 따로 생성
  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // 삭제 버튼 누르는 경우 뜨는 팝업 Dialog
          title: Text("정말로 삭제하시겠습니까?"),
          // 배열로 원하는 위젯 넣을 수 있는 파라미터 actions
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                setState(() {
                  // index에 해당하는 항목 삭제
                  bucketList.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// 버킷 생성 페이지
/// "텍스트 입력 여부"라는 상태에 따라 화면 갱신하여 에러 메시지 표시해야 함
/// CreatePage를 StatefulWidget으로 변경함
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

// CreatePage의 상태를 관리하는 _CreatePageState
class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용하는 textController
  // '추가하기' 버튼 클릭 시 현재 작성한 텍스트 값을 가져오도록 함
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  // 경고 문구를 안 띄우려면 null로 할당해야 할 때도 있으므로 String? 타입으로 변수 생성
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷리스트 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textController, // 연결해 줍니다.
              autofocus: true,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력하세요",
                errorText: error,
              ),
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  // textController 이용하여 TextField에 입력된 값을 가져옴
                  String job = textController.text; // 값 가져오기

                  // job 변수가 비어있는 경우 경고 메시지 띄우기
                  if (job.isEmpty) {
                    setState(() {
                      error = "내용을 입력해주세요."; // 내용이 없는 경우 에러 메세지
                    });
                  } else {
                    setState(() {
                      error = null; // 내용이 있는 경우 에러 메세지 숨기기
                    });
                    Navigator.pop(context, job); // job 변수를 반환하며 화면을 종료합니다.
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
