import 'package:flutter/cupertino.dart';

class WriteStoryScreen extends StatefulWidget {
  final String imageUrl;

  WriteStoryScreen({required this.imageUrl});

  @override
  _WriteStoryScreenState createState() => _WriteStoryScreenState();
}

class _WriteStoryScreenState extends State<WriteStoryScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Write Your Story'),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
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
            SizedBox(height: 20),
            CupertinoTextField(
              controller: _titleController,
              placeholder: 'Enter Title',
              decoration: BoxDecoration(
                border: Border.all(color: CupertinoColors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(12.0),
            ),
            SizedBox(height: 20),
            CupertinoTextField(
              controller: _contentController,
              placeholder: 'Enter Content',
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: BoxDecoration(
                border: Border.all(color: CupertinoColors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(12.0),
            ),
            SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: () {
                // 여기서 글을 저장하는 로직을 구현할 수 있습니다.
                String title = _titleController.text;
                String content = _contentController.text;
                // 글을 저장하는 함수 호출 또는 다른 로직 수행
                // 예: saveStory(title, content);
                // 저장이 완료되면 홈 화면으로 돌아가기
                Navigator.pop(context);
              },
              child: Text('Publish'),
            ),
          ],
        ),
      ),
    );
  }
}
