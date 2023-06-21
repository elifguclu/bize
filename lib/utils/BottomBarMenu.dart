import 'package:bize/constants.dart';
import 'package:bize/screens/Post.dart';
import 'package:bize/screens/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bize/screens/Home.dart';

void main() {
  runApp(const BottomBarMenu());
}

class BottomBarMenu extends StatefulWidget {
  const BottomBarMenu({super.key});

  @override
  State<BottomBarMenu> createState() => _BottomBarMenu();
}

class _BottomBarMenu extends State<BottomBarMenu> {
  int _selectedIndex = 0;

  //New
  static const List<Widget> _pages = <Widget>[
    Home(),
    Post(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffc2cddb),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              width: 39,
              height: 36,
              child: SvgPicture.asset(
                IconConstants.dashboard,
                //'assets/icons/home.svg',
                color: _selectedIndex == 0 ? Color(0xffff006f) : Colors.black,
              ),
            ),
            label: '', // home
            backgroundColor: Color(0xffc2cddb),
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 39,
              height: 36,
              child: SvgPicture.asset(
                IconConstants.post,
                //'assets/icons/post.svg',
                color: _selectedIndex == 1 ? Color(0xffff006f) : Colors.black,
              ),
            ),
            label: '', //post
            backgroundColor: Color(0xffc2cddb),
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 39,
              height: 36,
              child: SvgPicture.asset(
                IconConstants.profile,
                //'assets/icons/profile.svg',
                color: _selectedIndex == 2 ? Color(0xffff006f) : Colors.black,
              ),
            ),
            label: '', // profile
            backgroundColor: Color(0xffc2cddb),
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
