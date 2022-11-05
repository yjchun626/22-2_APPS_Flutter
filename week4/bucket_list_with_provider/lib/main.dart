import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bucket_service.dart';

void main() {
  runApp(
    // Multiprovider로 MyApp을 감싸서 모든 위젯들의 최상단에 provider들을 등록
    // Multiprovider는 위젯트리 꼭대기에 여러 서비스들을 등록 가능하게 만듦
    MultiProvider(
      // BucketService는 bucketList 값이 변하는 경우 HomePage에 변경사항을 알려주도록 함
      // 따라서 ChangeNotifierProvider로 Provider에 등록함
      providers: [
        ChangeNotifierProvider(create: (context) => BucketService()),
      ],
      child: const MyApp(),
    ),
  );
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
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Consumer 위젯 사용하면 위젯트리 꼭대기에 등록된 BucketService에 접근 가능
    /// Consumer<> : 위젯트리 상단에서 찾아올 클래스 이름을 <> 사이에 적어줌

    //// builder: (context, bucketService, child) { return 위젯; }
    // 화면에 보여줄 위젯을 반환하는 함수, 위젯트리 상단에서 찾아온 클래스를 두 번째 파라미터로 받을 수 있다.

    return Consumer<BucketService>(
      builder: (context, bucketService, child) {
        // bucketService로 부터 bucketList 가져오기
        List<Bucket> bucketList = bucketService.bucketList;
        return Scaffold(
          appBar: AppBar(
            title: Text("버킷 리스트"),
          ),
          // bucketList를 HomePage가 아닌 BucketService에서 가져오는 것!
          body: bucketList.isEmpty
              ? Center(child: Text("버킷 리스트를 작성해 주세요."))
              : ListView.builder(
                  itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
                  itemBuilder: (context, index) {
                    var bucket = bucketList[index]; // index에 해당하는 bucket 가져오기
                    return ListTile(
                      // 버킷 리스트 할 일
                      title: Text(
                        bucket.job,
                        style: TextStyle(
                          fontSize: 24,
                          color: bucket.isDone ? Colors.grey : Colors.black,
                          decoration: bucket.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      // 삭제 아이콘 버튼
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.delete),
                        onPressed: () {
                          // 삭제 버튼 클릭시
                          bucketService.deleteBucket(index);
                        },
                      ),
                      onTap: () {
                        // 아이템 클릭시
                        bucket.isDone = !bucket.isDone;
                        bucketService.updateBucket(bucket, index);
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // + 버튼 클릭시 버킷 생성 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreatePage()),
              );
            },
          ),
        );
      },
    );
  }
}

/// 버킷 생성 페이지
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용합니다.
  TextEditingController textController = TextEditingController();

  // 경고 메세지
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
              controller: textController,
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
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      error = "내용을 입력해주세요."; // 내용이 없는 경우 에러 메세지
                    });
                  } else {
                    setState(() {
                      error = null; // 내용이 있는 경우 에러 메세지 숨기기
                    });
                    // BucketService 가져오기
                    BucketService bucketService = context.read<BucketService>();
                    bucketService.createBucket(job);
                    Navigator.pop(context); // 화면을 종료합니다.
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
