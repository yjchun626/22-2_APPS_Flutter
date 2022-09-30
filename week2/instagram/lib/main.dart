import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 앱을 시작할 때 MaterialApp으로 앱을 시작
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// home이라는 이름 지정 매개변수에 첫 번째 페이지 위젯을 만들어 전달
