import 'package:flutter/material.dart';
Color myColor1 = const Color(0xFFFFE3D9);
Color myColor2 = const Color(0xFFFFC7AE);
Color myColor3 = const Color(0xFFF98C6E);
Color myColor4 = const Color(0xFF471900);



class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  MyBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // 네비게이션 바 설정
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: 'Edit',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_copy),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.area_chart),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: myColor3, // 선택된 아이템의 색상
      unselectedItemColor: myColor2, // 선택되지 않은 아이템의 색상
      onTap: onItemTapped,
    );
  }
}
