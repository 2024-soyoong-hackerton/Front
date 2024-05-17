import 'package:flutter/material.dart';
import 'package:untitled3/login.dart';
import 'package:untitled3/myPage.dart';
import 'package:untitled3/myStory.dart';
import 'package:untitled3/selectPhoto.dart';
import 'package:untitled3/widgets/appBar.dart';
import 'widgets/bottomNavigatorBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 컬럼의 정렬을 시작점에 맞춥니다.
        children: [
          //광고배너
          Container(
            height: 158,
            child: Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 300, // 이미지의 높이 설정
                    child: Image(
                      image: AssetImage('assets/images/advertise1.png'),
                      fit: BoxFit.cover,// AssetImage 사용
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 300, // 이미지의 높이 설정
                    child: Image(
                      image: AssetImage('assets/images/advertise1.png'),
                      fit: BoxFit.cover,// AssetImage 사용
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 300, // 이미지의 높이 설정
                    child: Image(
                      image: AssetImage('assets/images/advertise1.png'),
                      fit: BoxFit.cover,// AssetImage 사용
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 나머지 부분은 그대로 둡니다.
          Padding(
            padding: const EdgeInsets.only(left:15),
            child: SizedBox(
              height: 50,
              child: Image(
                image: AssetImage('assets/images/#myrecord.png'),
              ),
            ),
          ),
          //나의 글들

          Container(
            height: 200,
            child: Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 100, // 이미지의 높이 설정
                    child: Image(
                      image: AssetImage('assets/images/myStory.png'),
                      fit: BoxFit.cover,// AssetImage 사용
                    ),
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15),
            child: SizedBox(
              height: 18,
              child: Image(
                image: AssetImage('assets/images/#myfriends.png'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  // height: 5,
                  child: Image(
                    image: AssetImage('assets/images/friendsstory.png'),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 0, onItemTapped: (int index) {
          // 이동 로직을 여기에 구현합니다.
          // 예를 들어, 다음과 같이 사용할 수 있습니다.

          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ImageSelectScreen()),//임시로 이미지 셀렉 화면임!
            );
    } else if (index == 2) {
      Navigator.pushNamed(context, '/notifications');
    } else if (index == 3) {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MyStoryScreen()),//임시로 이미지 셀렉 화면임!
    );
    }
          else  if (index == 4) {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MyPage()),//임시로 이미지 셀렉 화면임!
    );}
  }
    ,),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
