import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_commenter_fire_store_controller.dart';
import 'package:dream/models/commenter.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/card_details.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDetailsCommenterScreen extends StatefulWidget {
  const ShowDetailsCommenterScreen({Key? key, this.commenter,})
      : super(key: key);
  final Commenter? commenter;


  @override
  State<ShowDetailsCommenterScreen> createState() => _ShowDetailsCommenterScreenState();
}

class _ShowDetailsCommenterScreenState extends State<ShowDetailsCommenterScreen> with Helpers {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'تفاصيل المفسر',
            style: GoogleFonts.cairo(),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Commenter>>(
          stream: FbCommenterFireStoreController()
              .readCommenterDetails(id: widget.commenter!.idDoc!),
          builder: (context, snapshot) {
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
                        SizedBox(
                          height: 15.h,
                        ),

                        CardDetails(
                          staticTitle: ': الاسم',
                          title: snapshot.data!.docs[0].data().userName,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CardDetails(
                          staticTitle: ': الرقم',
                          title: snapshot.data!.docs[0].data().phoneNumber,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CardDetails(
                          staticTitle: ': عدد مرات تفسير الحلم',
                          title: snapshot.data!.docs[0].data().counter.toString(),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CardDetails(
                          staticTitle: ': الايميل',
                          title: snapshot.data!.docs[0].data().email,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CardDetails(
                          staticTitle: ': كلمة المرور',
                          title: snapshot.data!.docs[0].data().password,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        ElevatedButton(
                          onPressed: () {
                            _updateCounter();
                          },
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            elevation: 0,
                            primary: Colors.red,
                            minimumSize: Size(double.infinity, 48.h),
                          ),
                          child: Text(
                            'تصفية العداد',
                            style: GoogleFonts.ubuntu(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h,)
                        ,ElevatedButton(
                          onPressed: () {
                            _deleteCommenter(path: snapshot.data!.docs[0].data().idDoc!);
                          },
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            elevation: 0,
                            primary: Colors.red,
                            minimumSize: Size(double.infinity, 48.h),
                          ),
                          child: Text(
                            'حذف مفسر',
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
                  'لا يوجد مفسرين بعد',
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

  Commenter getDream(QueryDocumentSnapshot<Commenter> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }

  Future<void> _updateCounter() async {
    await FbCommenterFireStoreController().updateCounterDown(
      IdDocCommenter: widget.commenter!.idDoc!,
      counterCommenter: widget.commenter!.counter,
    );
  }
  Future<void> _deleteCommenter(
      {
        required String path,
      }) async {
    await FbCommenterFireStoreController().delete(
        path: path
    );
    showSnackBar(context, message: 'تم حذف مفسر بنجاح', error: false);

    Navigator.pop(context);
  }
}
