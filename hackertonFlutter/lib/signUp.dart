import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Color myColor1 = const Color(0xFFFFE3D9);
Color myColor2 = const Color(0xFFFFC7AE);
Color myColor3 = const Color(0xFFF98C6E);
Color myColor4 = const Color(0xFF471900);



void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        textSelectionTheme : TextSelectionThemeData(
            cursorColor: myColor3)
    ),
    home: SignUpScreen(),
  ));
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      // Perform the signup logic here
      String name = _nameController.text;
      String id = _idController.text;
      String password = _passwordController.text;

      try {
        var dio = Dio();
        var response = await dio.post(
          'http://43.203.31.163:3000/api/user',
          data: {
            'name': name,
            'id': id,
            'password': password,
          },
        );
        print(response.data);
        if (response.statusCode == 200) {
          print('Sign up successful');
          // Clear the text fields
          _nameController.clear();
          _idController.clear();
          _passwordController.clear();
        } else {
          print('Sign up failed: ${response.statusCode}');
        }
      } catch (e) {
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
          child: Image.asset('assets/logo.png'), // 로고 이미지
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
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
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _idController,

                decoration: InputDecoration(
                  labelText: 'Id',
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
                    return 'Please enter a Id';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myColor1), // 포커스가 없을 때의 밑줄 색상 변경
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: myColor3),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myColor3), // 포커스를 받았을 때의 밑줄 색상 변경
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  foregroundColor: myColor3,
                  // backgroundColor: myColor1,
                ),
                child: Text('Sign Up'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
