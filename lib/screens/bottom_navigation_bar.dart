import 'package:dream/screens/favorite_screen.dart';
import 'package:dream/screens/home_screen.dart';
import 'package:dream/screens/my_dream_screens/my_dream_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _navScreens = <Widget>[
    HomeScreen(),

     FavoriteScreen(),

    MyDreamScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navScreens.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.white,

        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.w, vertical: 7.h),
          child: GNav(

            selectedIndex: _selectedIndex,
            rippleColor: Colors.white,
            // tab button ripple color when pressed
            hoverColor: Colors.white,
            // tab button hover color// tab button hover color
            haptic: true,
            // haptic feedback
            tabBorderRadius: 15.r,
            curve: Curves.easeOutExpo,
            // tab animation curves
            duration: const Duration(milliseconds: 900),
            // tab animation duration
            gap: 8.w,

            onTabChange: (index) {
              _selectedIndex = index;
              setState(() {});
            },

            // the tab button gap between icon and text
            color: Colors.blue,
            // unselected icon color
            activeColor: Color(0xff28A9E1),
            // selected icon and text color
            iconSize: 30.r,
            // tab button icon size
            tabBackgroundColor: Colors.blue.shade100,
            // selected tab background color
            // padding: EdgeInsets.only(
            //     left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h), // navigation bar padding
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'الرئيسة',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'المفضلة',textSize: 35,
              ),
              GButton(
                icon: Icons.perm_identity_outlined,
                text: 'احلامي',
              ),

            ],
          ),
        ),
      ),
    );
  }
}
