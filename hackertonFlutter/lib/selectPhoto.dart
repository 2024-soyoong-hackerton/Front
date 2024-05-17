import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:untitled3/signUp.dart';
import 'writeStory.dart';



void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textSelectionTheme : TextSelectionThemeData(
          cursorColor: myColor3)
    ),
    home: ImageSelectScreen(),
  ));
}

class ImageSelectScreen extends StatefulWidget {
  @override
  _ImageSelectScreenState createState() => _ImageSelectScreenState();
}

class _ImageSelectScreenState extends State<ImageSelectScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> uploadFile() async {
    if (_image == null) return;

    var dio = Dio();
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(_image!.path),
    });

    try {
      var response = await dio.post('http://43.203.31.163:3000/api/image/upload', data: formData);
      if (response.statusCode == 201) {
        print('File uploaded successfully');
        var message = response.data;
        print('Message from server: $message');
        var imageUrl = message['data']['imagePath'];//받은 이미지 Url
        print("imagePath = $imageUrl");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WriteStoryScreen(imageUrl: imageUrl,)),
        );
      } else {
        print('File upload failed: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New moment', style: TextStyle(color: myColor3),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.', style: TextStyle(color: myColor2),)
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: myColor1, // 배경색을 myColor1로 설정
              ),
              onPressed: uploadFile,
              child: Text('Upload Image', style: TextStyle(color: myColor4),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myColor1,
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo, color: myColor4),
      ),
    );
  }
}
