import 'package:bloodintern/view/pages/homescreen.dart';
import 'package:bloodintern/view/pages/noltification.dart';
import 'package:bloodintern/view/pages/profile.dart';
import 'package:bloodintern/view/pages/soscreen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
 // filename should be changed too



class Bottomnavibarscreen extends StatefulWidget {
  const Bottomnavibarscreen({super.key});

  @override
  State<Bottomnavibarscreen> createState() => _BottomnavibarscreenState();
}

class _BottomnavibarscreenState extends State<Bottomnavibarscreen> {
  int selecttab = 0;

  final List<Widget> screens = [
    Homescreen(),
    NotificationScreen(notifications: notifications,),
    Soscreen(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selecttab],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (int index) {
        setState(() {
          selecttab = index;
        });
      },
      selectedItemColor: Colors.black,
      currentIndex: selecttab,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.red.shade400,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.notifications),
          icon: Icon(Icons.notifications_outlined),
          label: "Notification",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.emergency),
          icon: Icon(Icons.emergency_outlined),
          label: "SOS",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outlined),
          label: "Profile",
        ),
      ],
    );
  }
}