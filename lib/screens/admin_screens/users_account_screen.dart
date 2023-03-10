import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_users_fire_sire_controller.dart';
import 'package:dream/models/users.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UsersAccountScreen extends StatelessWidget {
  const UsersAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Users>>(
          stream: FbUsersFireStoreController().read(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingScreen(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: [
                  Column(
                    children: [
                      Text(
                        '(${snapshot.data!.docs.length}): عدد الاشخاص المسجلين في التطبيق',
                        style: GoogleFonts.cairo(fontSize: 15.sp),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            // var dream2 = getDream(
                            //   snapshot.data!.docs[index],
                            // );
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 15.h),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 10.h),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AutoSizeText(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data()
                                                            .userName,
                                                        style:
                                                            GoogleFonts.cairo(
                                                                fontSize:
                                                                    15.sp),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        ':الاسم',
                                                        style:
                                                            GoogleFonts.cairo(
                                                                fontSize:
                                                                    10.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      AutoSizeText(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data()
                                                            .email,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.cairo(
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        ':الايميل',
                                                        style:
                                                            GoogleFonts.cairo(
                                                                fontSize:
                                                                    10.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(height: 5.h),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons
                                                  .calendar_month_outlined),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                DateFormat.yMd()
                                                    .add_jm()
                                                    .format(
                                                      DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data()
                                                            .createdDate,
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'لا يوجد مستخدمين بعد',
                  style: GoogleFonts.cairo(fontSize: 20.sp),
                ),
              );
            }
          }),
    );
  }

  Users getDream(QueryDocumentSnapshot<Users> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }
}
