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
      body: Feed(),
    );
  }
}
