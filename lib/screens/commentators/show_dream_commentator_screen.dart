import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/commenter.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/screens/commentators/add_reply_screen.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/btn_auth.dart';
import 'package:dream/widgets/card_details.dart';
import 'package:dream/widgets/card_dream.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDreamCommentatorScreen extends StatefulWidget {
  ShowDreamCommentatorScreen({Key? key, this.dream, this.commenter})
      : super(key: key);
  final Dream? dream;
  final Commenter? commenter;

  @override
  State<ShowDreamCommentatorScreen> createState() => _ShowDreamScreenState();
}

class _ShowDreamScreenState extends State<ShowDreamCommentatorScreen>
    with Helpers {
  late TextEditingController _messageTextController;

  @override

  void initState() {
    super.initState();

    _messageTextController = TextEditingController();
  }

  @override
  void dispose() {
    _messageTextController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Center(
          child: Text('تفاصيل الحلم'),
        ),
        leading: Text(''),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'تم',
                style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Dream>>(
          stream: FbFireStoreController()
              .readDreamDetails(id: widget.dream!.idDoc!),
          builder: (context, snapshot) {



            // if (snapshot.data!.docs[0].data().wasCommented ==
            //     false) {
            //   color = Colors.lightGreen;
            // }
            // else {
            //   color = Colors.grey;
            // }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingScreen(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 15.h),
                    child: Column(
                      children: [
                        CardDream(
                          trailing: Text(''),
                          dream: getDream(
                            snapshot.data!.docs[0],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CardDetails(
                          staticTitle: ': الجنس',
                          title: snapshot.data!.docs[0].data().gender,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CardDetails(
                          staticTitle: ': الحالة الاجتماعية',
                          title: snapshot.data!.docs[0].data().maritalstatus,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CardDetails(
                          staticTitle: ': الحالة الوظيفية',
                          title: snapshot.data!.docs[0].data().functionalStatus,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CardDetails(
                          staticTitle: ': العمر',
                          title: snapshot.data!.docs[0].data().age,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2.r,
                                  blurRadius: 3.r,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 200.0.h,
                            child: Padding(
                              padding:  EdgeInsets.all(15.0.w),
                              child: ListView(
                                children: [
                                  Text(
                                    snapshot.data!.docs[0]
                                                .data()
                                                .replyMessage
                                                .toString() ==
                                            ''
                                        ? 'لم يتم الرد على الحلم بعد'
                                        : snapshot.data!.docs[0]
                                            .data()
                                            .replyMessage
                                            .toString(),
                                    style:
                                        GoogleFonts.cairo(color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            !snapshot.data!.docs[0].data().wasCommented==true?   await _confirmationProcess(context):false;
                          },
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            elevation: 0,

                            backgroundColor: !snapshot.data!.docs[0].data().wasCommented ? Colors.lightGreen:Colors.grey,
                            minimumSize: Size(double.infinity, 48.h),
                          ),
                          child: Text(
                            'اضافة رد',
                            style: GoogleFonts.ubuntu(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'لا يوجد احلام بعد',
                  style: GoogleFonts.cairo(fontSize: 20.sp),
                ),
              );
            }
          }),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13.r),
      borderSide: BorderSide(
        width: 1.w,
        color: color,
      ),
    );
  }

  Dream getDream(QueryDocumentSnapshot<Dream> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }

  Future<void> _confirmationProcess(BuildContext context) async {
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
                'هل انت متاكد من انك تريد الرد على هذا الحلم؟؟',
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('تأكيد'),
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
                'هل انت متاكد من انك تريد الرد على هذا الحلم؟؟',
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('تأكيد'),
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
      _updateFlag();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddReplyScreen(
              idDream: widget.dream!.idDoc!,
              commenter: widget.commenter,
              dream :widget.dream,
            ),
          ));
    }
    //showAboutDialog(context: context,applicationName:'ديباج',applicationIcon: Image(image: AssetImage('images/dream-logo.png',),) ,applicationVersion: '3.0.2' );
  }

  Future<void> _updateFlag() async {
    await FbFireStoreController()
        .updateFlagBtnCommenterDisable(IdDocDream: widget.dream!.idDoc!);
  }
}
