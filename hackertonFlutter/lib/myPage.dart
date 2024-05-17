import 'package:flutter/material.dart';
import 'package:untitled3/myStory.dart';
import 'package:untitled3/widgets/appBar.dart';
import 'package:untitled3/widgets/bottomNavigatorBar.dart';
import 'package:untitled3/home.dart';
import 'package:untitled3/selectPhoto.dart';
import 'login.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/images/myPage.png'), // 자신의 이미지 경로로 변경하세요
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          // 추가적인 위젯들을 여기에 추가할 수 있습니다.
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 4, // 해당 인덱스로 설정하세요
        onItemTapped: (int index) {
          // 이동 로직을 여기에 구현합니다.
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ImageSelectScreen()),
            );
          } else if (index == 2) {
            Navigator.pushNamed(context, '/notifications');
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyStoryScreen()),
            );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyPage()),
            );
          }
        },
      ),
    );
  }
}
