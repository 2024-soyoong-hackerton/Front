import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled3/home.dart';
import 'package:untitled3/login.dart';
import 'package:untitled3/myPage.dart';
import 'package:untitled3/selectPhoto.dart';

// main.dart
import 'package:flutter/material.dart';
import 'package:untitled3/signUp.dart';
import 'package:untitled3/writeStory.dart';
import 'graph.dart'; // graph.dart 파일을 임포트

Color myColor1 = const Color(0xFFFFE3D9);
Color myColor2 = const Color(0xFFFFC7AE);
Color myColor3 = const Color(0xFFF98C6E);
Color myColor4 = const Color(0xFF471900);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomeScreen(),
      // home: MyPage(),
      home : LoginScreen()
      // home: SignUpScreen(),
      // home: WriteStoryScreen(imageUrl: 'https://s3.ap-northeast-2.amazonaws.com/imageuploadserver/horizontal_image.jpg'),
      // home : ImageSelectScreen(),
      // home: LineChartScreen(), // 전체 화면을 LineChartScreen으로 설정
    );
  }
}
