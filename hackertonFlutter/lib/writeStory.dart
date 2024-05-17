import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/home.dart';
import 'package:untitled3/widgets/appBar.dart';
import 'signUp.dart';
import 'widgets/ThreeStepButton.dart';
import 'login.dart';

Color myColor1 = const Color(0xFFFFE3D9);
Color myColor2 = const Color(0xFFFFC7AE);
Color myColor3 = const Color(0xFFF98C6E);
Color myColor4 = const Color(0xFF471900);

class StoryInfo {
  String photo;
  String title;
  String content;
  int age;
  int estimation;
  int level;

  StoryInfo({
    required this.photo,
    required this.title,
    required this.content,
    required this.age,
    required this.estimation,
    required this.level,
  });

  void printInfo() {
    print('Photo: $photo');
    print('Title: .$title.');
    print('Content: .$content.');
    print('Age: $age');
    print('Estimation: $estimation');
    print('Level: $level');
  }
}

late StoryInfo myStoryInfo;
late String photo;

class WriteStoryScreen extends StatefulWidget {
  final String imageUrl;

  WriteStoryScreen({required this.imageUrl});

  @override
  _WriteStoryScreenState createState() => _WriteStoryScreenState();
}

class _WriteStoryScreenState extends State<WriteStoryScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  late int _selectedAge;
  late int _selectedEstimation;
  late int _selectedLevel;

  @override
  void initState() {
    super.initState();
    _selectedAge = 0; // 기본 나이 값 설정
    _selectedEstimation = -11; // 기본 감정지수 값 설정
    _selectedLevel = 0; // 기본 공감단계 값 설정
  }

  void publish() async {
    // 여기서 글을 저장하는 로직을 구현합니다.
    String title = _titleController.text;
    String content = _contentController.text;

    if (title == '' ||
        content == '' ||
        _selectedAge == 0 ||
        _selectedEstimation == 0 ||
        _selectedLevel == 0) {
      // 오류 메시지를 화면에 표시합니다.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: myColor4),
            ),
            content: Text(
              'Please fill out all the required fields.',
              style: TextStyle(color: myColor4),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: myColor4),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    myStoryInfo = StoryInfo(
      photo: widget.imageUrl,
      title: _titleController.text,
      content: _contentController.text,
      age: _selectedAge.toInt(),
      estimation: _selectedEstimation.toInt(),
      level: _selectedLevel.toInt(),
    );
    myStoryInfo.printInfo();

    //정보 보내는 부분
    try {
      var dio = Dio();

      // 헤더에 토큰을 포함하여 요청을 보냅니다.
      dio.options.headers['Authorization'] = 'Bearer $access_token';
      print('post start');
      var response = await dio.post(
        'http://43.203.31.163:3000/api/memory',
        data: {
          'level': myStoryInfo.level.toInt(),
          'photo': myStoryInfo.photo.toString(),
          'title': myStoryInfo.title.toString(),
          'content': myStoryInfo.content.toString(),
          'age': myStoryInfo.age.toInt(),
          'estimation': myStoryInfo.estimation.toInt(),
          // 기타 필요한 정보를 추가합니다.
        },
      );
      print(">>>");
      if (response.statusCode == 201) {
        print('Writing successfully');
        var message = response;
        print('Message from server: $message');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        print(response);
        print('File upload failed: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }


    // 저장이 완료되면 홈 화면으로 돌아가기
    print('publish');
    print(_selectedEstimation);
    print(_selectedLevel);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 이미지를 표시하는 컨테이너
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height: 400, // 이미지 높이 조정
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        hintText: '제목을 입력해주세요.',
                        hintStyle: TextStyle(color: myColor3),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: myColor3), // 동적 border 색상
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: myColor2))),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      hintText: '어떤 일이 있었나요?',
                      hintStyle: TextStyle(color: myColor3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: myColor1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: myColor3), // 동적 border 색상
                      ),
                    ),
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
                    minLines: 4, // 최소 높이 설정
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: myColor1), // 포커스가 없을 때의 밑줄 색상 변경
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: myColor2), // 포커스를 받았을 때의 밑줄 색상 변경
                        ),
                      ),
                      style: TextStyle(color: myColor3),
                      // 드롭다운 버튼의 텍스트 색상 변경
                      // dropdownColor: myColor3, // 드롭다운 버튼을 눌렀을 때 나타나는 아이템의 배경색 변경
                      icon: Icon(Icons.arrow_downward, color: myColor3),
                      value: null,
                      hint: Text(
                        '나이 선택',
                        style: TextStyle(color: myColor3),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedAge = value!;
                        });
                      },
                      items: List.generate(100, (index) => index + 1)
                          .map<DropdownMenuItem<int>>(
                              (value) => DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: myColor1), // 포커스가 없을 때의 밑줄 색상 변경
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: myColor2), // 포커스를 받았을 때의 밑줄 색상 변경
                        ),
                      ),
                      style: TextStyle(color: myColor3),
                      // 드롭다운 버튼의 텍스트 색상 변경
                      // dropdownColor: myColor3, // 드롭다운 버튼을 눌렀을 때 나타나는 아이템의 배경색 변경
                      icon: Icon(Icons.arrow_downward, color: myColor3),
                      value: null,
                      hint: Text(
                        '감정지수 선택',
                        style: TextStyle(color: myColor3),
                      ),
                      onChanged: (value) {
                        // print("selected : $value");
                        setState(() {
                          _selectedEstimation = value!;
                        });
                      },
                      items: List.generate(21, (index) => index - 10)
                          .map<DropdownMenuItem<int>>(
                              (value) => DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 25),
                  ThreeStepButton(
                    value: _selectedLevel ?? 1,
                    onChanged: (value) {
                      setState(
                        () {
                          _selectedLevel = value;
                        },
                      );
                    },
                    label: '공개단계',
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myColor1, // 배경색을 myColor1로 설정
                    ),
                    onPressed: publish,
                    child: Text(
                      'Publish',
                      style: TextStyle(color: myColor4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
