import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'writeStory.dart';

void main() {
  runApp(MaterialApp(
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
      final filePath = pickedFile.path;
      var dio = Dio();
      var formData = FormData.fromMap({'image': await MultipartFile.fromFile(filePath)});
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
        var imagePath = message['data']['imagePath'];//받은 이미지 Url
        print("imagePath = $imagePath");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WriteStoryScreen(imageUrl: imagePath,)),
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
        title: Text('New moment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
