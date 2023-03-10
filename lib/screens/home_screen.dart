import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/screens/show_dream_screen.dart';
import 'package:dream/widgets/card_dream.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          // IconButton(
          //   onPressed: () {
          //
          //     Navigator.pushNamed(context,'/login_admin_screen' );
          //   },
          //   icon: Icon(
          //     Icons.safety_divider,
          //     size: 30,
          //     color: Colors.white,
          //   ),
          // ),
        ],
        title: const Center(
          child: Text('عرض الاحلام'),
        ),
      ),
      endDrawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          'images/dream-logo-2.png',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(35.r),
                    color: Colors.transparent,
                  ),
                ),
                accountName: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 10.h),
                    child: Text(
                      'ديباج لتفسير الاحلام',
                      style: GoogleFonts.cairo(fontSize: 20.sp),
                    ),
                  ),
                ),
                accountEmail:
                    const Align(alignment: Alignment.topRight, child: Text('')),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topEnd,
                    end: AlignmentDirectional.bottomStart,
                    colors: [
                      Color(0XFF28A9E1),
                      Color(0XFF28A9E1),
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/contact_us_add_screen');
                },
                leading: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.h,
                ),
                title: const Align(
                  alignment: Alignment.topRight,
                  child: Text('تواصل معنا'),
                ),
                trailing: Icon(
                  Icons.mark_as_unread_sharp,
                  size: 20.h,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login_screen');
                },
                leading: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.h,
                ),
                title: const Align(
                  alignment: Alignment.topRight,
                  child: Text('تسجيل الدخول'),
                ),
                trailing: Icon(
                  Icons.login,
                  size: 20.h,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/about_screen');
                },
                leading: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                ),
                title: const Align(
                  alignment: Alignment.topRight,
                  child: Text('عن التطبيق'),
                ),
                trailing: Icon(
                  Icons.info,
                  size: 20,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  showAboutDialog(
                      context: context,
                      applicationName: 'ديباج',
                      applicationIcon: FlutterLogo(),
                      applicationVersion: '3.0.2');
                },
                leading: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.h,
                ),
                title: const Align(
                  alignment: Alignment.topRight,
                  child: Text('سياسة الخصوصية'),
                ),
                trailing: Icon(
                  Icons.add_moderator_outlined,
                  size: 20.h,
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
                indent: 30,
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  await _confirmSignOut(context);
                },
                title: const Align(
                  alignment: Alignment.topRight,
                  child: Text('تسجيل الخروج'),
                ),
                trailing: Icon(
                  Icons.logout,
                  size: 20.h,
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Dream>>(
          stream: FbFireStoreController().readAllDreamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingScreen(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dream2 = getDream(
                      snapshot.data!.docs[index],
                    );
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowDreamScreen(
                              dream: snapshot.data!.docs[index].data(),
                              idDoc: snapshot.data!.docs[index].data().idDoc,
                              counterDream:
                                  snapshot.data!.docs[index].data().counter,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15.0.w),
                        child: CardDream(
                          trailing: const Text(''),
                          dream: dream2,
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text(
                  'لا يوجد احلام بعد',
                  style: GoogleFonts.cairo(fontSize: 20.sp),
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String route = FbAuthController().loggedIn
              ? '/add_dream_screen'
              : '/login_screen';
          Navigator.pushNamed(context, route);
        },
        backgroundColor: const Color(0xff28A9E1),
        label: const Text('اضافة حلم'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Dream getDream(QueryDocumentSnapshot<Dream> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    bool? result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (Platform.isAndroid) {
            return AlertDialog(


              title: Text(
                'هل انت متأكد؟',
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'ستقوم بالخروج من التطبيق',
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('الخروج'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('اغلاق'),
                ),
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(
                'هل انت متأكد؟',
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'ستقوم بالخروج من التطبيق',
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('الخروخ'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('اغلاق'),
                ),
              ],
            );
          }
        });
    if (result ?? false) {
      await _signOut(context);
    }
    //showAboutDialog(context: context,applicationName:'ديباج',applicationIcon: Image(image: AssetImage('images/dream-logo.png',),) ,applicationVersion: '3.0.2' );
  }

  Future<void> _signOut(BuildContext context) async {
    await FbAuthController().signOut();
    Navigator.pushReplacementNamed(context, '/bottom_navigation_bar');
  }
}
