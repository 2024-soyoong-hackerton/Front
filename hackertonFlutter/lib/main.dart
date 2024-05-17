import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled3/selectPhoto.dart';

// main.dart
import 'package:flutter/material.dart';
import 'package:untitled3/signUp.dart';
import 'package:untitled3/writeStory.dart';
import 'graph.dart'; // graph.dart 파일을 임포트

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
      // home: WriteStoryScreen(imageUrl: 'https://s3.ap-northeast-2.amazonaws.com/imageuploadserver/horizontal_image.jpg'),
      // home : ImageSelectScreen(),
      // home: LineChartScreen(), // 전체 화면을 LineChartScreen으로 설정
    );
  }
}
