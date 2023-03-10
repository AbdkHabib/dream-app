import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_connect_fire_store_controller.dart';
import 'package:dream/models/connect.dart';
import 'package:dream/widgets/icon_dream.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ConnectReadScreen extends StatefulWidget {
  const ConnectReadScreen({Key? key}) : super(key: key);

  @override
  State<ConnectReadScreen> createState() => _ConnectReadScreenState();
}

class _ConnectReadScreenState extends State<ConnectReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Connect>>(
          stream: FbConnectFireStoreController().read(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingScreen(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 10.h),
                    child: Column(
                      children: [
                        Text(
                          '(${snapshot.data!.docs.length}): عدد الشكاوى ',
                          style: GoogleFonts.cairo(fontSize: 15.sp),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var dream2 = getDream(
                              snapshot.data!.docs[index],
                            );
                            return InkWell(
                                // onTap: () {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => ShowDreamScreen(
                                //         dream: snapshot.data!.docs[index].data(),
                                //         idDoc: snapshot.data!.docs[index].data().idDoc,
                                //         counterDream: snapshot.data!.docs[index].data().counter,
                                //       ),
                                //     ),
                                //   );
                                // },
                                child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                                    child: Column(
                                      children: [
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Flexible(
                                                        child: RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          strutStyle:
                                                               StrutStyle(
                                                                  fontSize:
                                                                      12.0.sp),
                                                          text: TextSpan(
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                            text: snapshot.data!
                                                                .docs[index]
                                                                .data()
                                                                .title,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        .data()
                                                        .description,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.cairo(
                                                      color: Colors.grey,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                   Divider(height: 5.h),
                                                   SizedBox(
                                                    height: 4.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                             SizedBox(
                                              width: 16.w,
                                            ),
                                            const IconDream(),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                             SizedBox(
                                              width: 5.w,
                                            ),
                                            const Icon(
                                                Icons.calendar_month_outlined),
                                            Text(
                                              DateFormat.yMd().add_jm().format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                      dream2.createdDate,
                                                    ),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height:25.h ,)

                              ],
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'لا يوجد ردود بعد',
                  style: GoogleFonts.cairo(fontSize: 20),
                ),
              );
            }
          }),
    );
  }

  Connect getDream(QueryDocumentSnapshot<Connect> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }
}
