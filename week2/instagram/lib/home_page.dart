import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'feed.dart';
import 'home_page.dart';

// statelessw 클래스 자동 생성
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "https://cdn2.thecatapi.com/images/bi.jpg",
      "https://cdn2.thecatapi.com/images/63g.jpg",
      "https://cdn2.thecatapi.com/images/a3h.jpg",
      "https://cdn2.thecatapi.com/images/a9m.jpg",
      "https://cdn2.thecatapi.com/images/aph.jpg",
      "https://cdn2.thecatapi.com/images/1rd.jpg",
      "https://cdn2.thecatapi.com/images/805.gif",
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.camera, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.paperplane, color: Colors.black),
            onPressed: () {},
          )
        ],
        title: Image.asset(
          // AppBar에 로고 삽입 - 중앙 정렬도
          'assets/logo.png',
          height: 32,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        // ListView 위젯: 동일한 레이아웃에 스크롤로써 다른 정보를 보여줄 때 사용
        itemCount: images.length, // 이미지 개수만큼 보여주기,
        itemBuilder: (context, index) {
          final image = images[index]; // index에 해당하는 이미지
          return Feed(imageUrl: image); // Feed 위젯에 imageUrl 전달
          // 데이터를 보여주는 껍데기 = 뷰(View)
          // View와 데이터를 분리하면 View를 재활용 할 수 있음
        },
      ),
    );
  }
}
