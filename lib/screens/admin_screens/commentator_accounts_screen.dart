import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_commenter_fire_store_controller.dart';
import 'package:dream/models/commenter.dart';
import 'package:dream/screens/admin_screens/show_details_commenter_screen.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CommenterAccountScreen extends StatelessWidget {
  const CommenterAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Commenter>>(
          stream: FbCommenterFireStoreController().read(),
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
                        '(${snapshot.data!.docs.length}): عدد المفسرين في التطبيق',
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
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShowDetailsCommenterScreen(
                                        commenter:
                                            snapshot.data!.docs[index].data(),
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 15.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 10.h),
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
                                                          Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .data()
                                                                .userName,
                                                            style: GoogleFonts
                                                                .cairo(
                                                                    fontSize:
                                                                        20.sp),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            ':الاسم',
                                                            style: GoogleFonts
                                                                .cairo(
                                                                    fontSize:
                                                                        20.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .data()
                                                                .email,
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .cairo(
                                                              fontSize: 20.sp,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            ':الايميل',
                                                            style: GoogleFonts
                                                                .cairo(
                                                                    fontSize:
                                                                        20.sp),
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
                                                            snapshot.data!
                                                                .docs[index]
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
                                ));
                          }),
                    ],
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'لا يوجد مفسرين بعد',
                  style: GoogleFonts.cairo(fontSize: 20.sp),
                ),
              );
            }
          }),
    );
  }

  Commenter getDream(QueryDocumentSnapshot<Commenter> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }
}
