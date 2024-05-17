import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/home.dart';
import 'package:untitled3/selectPhoto.dart';
import 'package:untitled3/widgets/appBar.dart';
import 'package:untitled3/widgets/bottomNavigatorBar.dart';
import 'login.dart';
import 'signUp.dart';

Color myColor1 = const Color(0xFFFFE3D9);
Color myColor2 = const Color(0xFFFFC7AE);
Color myColor3 = const Color(0xFFF98C6E);
Color myColor4 = const Color(0xFF471900);

String myTag = '분석 중 . . .';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textSelectionTheme: TextSelectionThemeData(cursorColor: myColor3),
    ),
    home: MyStoryScreen(),
  ));
}

class MyStoryScreen extends StatefulWidget {
  @override
  _MyStoryScreenState createState() => _MyStoryScreenState();
}

class _MyStoryScreenState extends State<MyStoryScreen> {
  // 데이터를 가져오는 메소드
  Future<void> fetchData() async {
    print('fetchdata start');
    print('userID = $UserId');
    try {
      var dio = Dio();
      // HTTP GET 요청을 보내고 응답을 기다립니다.
      var response = await dio.get('http://43.203.31.163:3000/api/user/graph/$UserId');
      print('response = $response');
      // 응답 데이터를 처리합니다.
      if (response.statusCode == 200) {
        // 성공적으로 데이터를 가져왔을 때 처리
        var second = response.data['data'];
        print('second fetched successfully: $second');
        var third = second['tag'];
        setState(() {
          myTag = third.toString();
        });
        print('third fetched successfully: $third');
      } else {
        // 데이터를 가져오지 못했을 때 처리
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // 에러 발생 시 처리
      print('Error fetching data: $e');
    }
    print('Data fetched successfully!');
  }

  @override
  void initState() {
    super.initState();
    myTag = '분석 중 . . .';
    fetchData(); // initState에서 데이터 가져오는 메소드 호출
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/images/timegraphtext.png'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  width: 800,
                  child: Image(
                    image: AssetImage('assets/images/graphImage.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
          Center(
            child: Text(
              myTag,
              style: TextStyle(color: myColor4, fontSize: 25, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 3,
        onItemTapped: (int index) {
          // 이동 로직을 여기에 구현합니다.
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), // HomeScreen으로 이동
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ImageSelectScreen()), // 이미지 선택 화면으로 이동
            );
          } else if (index == 2) {
            Navigator.pushNamed(context, '/notifications');
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyStoryScreen()), // MyStoryScreen으로 이동
            );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()), // LoginScreen으로 이동
            );
          }
        },
      ),
    );
  }
}
