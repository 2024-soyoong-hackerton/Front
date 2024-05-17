import 'package:flutter/material.dart';
import 'package:untitled3/login.dart';

import '../main.dart';
Color myColor1 = const Color(0xFFFFE3D9);
Color myColor2 = const Color(0xFFFFC7AE);
Color myColor3 = const Color(0xFFF98C6E);
Color myColor4 = const Color(0xFF471900);

class myAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50, // 로고 이미지의 높이
            ),
          SizedBox(
            height: 40, // 로고 이미지의 높이
            child: Image.asset('assets/images/hackerton_logo.png'), // 로고 이미지
          ),

          IconButton(
            icon: Icon(Icons.format_align_justify, color: myColor3,), // text_align_justify 아이콘
            onPressed: () {
              // text_align_justify 아이콘을 클릭했을 때 수행할 내용
            },
          ),
        ],
      ),
      centerTitle: true, // 중앙 정렬 설정
    );
  }
}


