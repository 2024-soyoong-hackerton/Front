import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:untitled3/home.dart';
import 'package:untitled3/selectPhoto.dart';
import 'package:untitled3/signUp.dart';
import 'package:untitled3/writeStory.dart';

import 'main.dart';

late String UserId;
Color myColor1 = const Color(0xFFFFE3D9);
Color myColor2 = const Color(0xFFFFC7AE);
Color myColor3 = const Color(0xFFF98C6E);
Color myColor4 = const Color(0xFF471900);

String access_token = '';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        textSelectionTheme : TextSelectionThemeData(
            cursorColor: myColor3)
    ),
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      // Perform the signup logic here
      String id = _idController.text;
      UserId = id;
      print('login:USerID:$UserId');
      String password = _passwordController.text;
      print('id = $id password = $password');
      if (id == '' || password == '')
        {
          print('error');
          showDialog(
              context: context,
              builder: (BuildContext context)
              {
                return AlertDialog(
                  title: Text('Error', style: TextStyle(color: myColor4),),
                  content: Text(
                    '아이디와 비밀번호를 모두 입력하세요.', style: TextStyle(color: myColor4),),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK', style: TextStyle(color: myColor4),),
                    ),
                  ],
                );
              });

        }
      try {
        var dio = Dio();
        var response = await dio.post(
          'http://43.203.31.163:3000/api/auth/login',
          data: {
            'id': id,
            'password': password,
          },
        );
        print('log');
        print(response.data);
        if (response.statusCode == 201) {
          var second = response.data['data'];
          var third = second['access_token'];
          print("seoncd : $second");
          print("third = $third");
          print("first : $response.data.data['access_token']");
          access_token = third.toString();
          print("access token : $access_token");
          print('login successful~~');
          // Clear the text fields
          _idController.clear();
          _passwordController.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),//임시로 이미지 셀렉 화면임!
          );
        }
        else {
          print('error');
          showDialog(
              context: context,
              builder: (BuildContext context)
              {
                return AlertDialog(
                  title: Text('Error', style: TextStyle(color: myColor4),),
                  content: Text(
                    '아이디와 비밀번호를 확인하세요', style: TextStyle(color: myColor4),),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK', style: TextStyle(color: myColor4),),
                    ),
                  ],
                );
              });
          print('Sign up failed: ${response.statusCode}');
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text('Error', style: TextStyle(color: myColor4),),
                content: Text(
                  '아이디와 비밀번호를 확인하세요', style: TextStyle(color: myColor4),),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK', style: TextStyle(color: myColor4),),
                  ),
                ],
              );
            });
        print('Error signing up: $e');

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40, // 로고 이미지의 높이
          child: Image.asset('assets/images/hackerton_logo.png'), // 로고 이미지
        ),
        centerTitle: true, // 중앙 정렬 설정
      ),
      //   appBar: AppBar(
      //     // title: Text('Sign Up', style: TextStyle(color: myColor3),),
      //   ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'Id',
                  labelStyle: TextStyle(color: myColor3),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myColor3), // 포커스가 없을 때의 밑줄 색상 변경
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myColor3), // 포커스를 받았을 때의 밑줄 색상 변경
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your id';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,

                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: myColor3),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myColor1), // 포커스가 없을 때의 밑줄 색상 변경
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myColor3), // 포커스를 받았을 때의 밑줄 색상 변경
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  foregroundColor: myColor4,
                  backgroundColor: myColor1,
                ),
                child: Text('Login'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: myColor4,
                  backgroundColor: myColor1,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),//임시로 이미지 셀렉 화면임!
                  );
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
