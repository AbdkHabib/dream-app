import 'dart:io';

import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/screens/home_screen.dart';
import 'package:dream/screens/my_dream_screens/all_my_dream_screen.dart';
import 'package:dream/screens/my_dream_screens/finished_dream_screen.dart';
import 'package:dream/screens/my_dream_screens/waiting_dream_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDreamScreen extends StatelessWidget {
  const MyDreamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('احلامي'),
            centerTitle: true,

            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'الكل',
                ),
                Tab(
                  text: 'قيد التفسير',
                ),
                Tab(
                  text: 'تم التفسير',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              const AllMyDreamScreen(),
              const WaitingDreamScreen(),
              const FinishedDreamScreen(),

            ],
          )),
    );
  }


}
