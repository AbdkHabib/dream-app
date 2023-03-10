import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/firebase/fb_favorite_controller.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/models/favorite.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/card_dream.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDreamScreen extends StatefulWidget {
  const ShowDreamScreen({
    Key? key,
    this.dream,
    this.idDoc,
    this.counterDream,
  }) : super(key: key);
  final Dream? dream;
  final String? idDoc;
  final int? counterDream;

  @override
  State<ShowDreamScreen> createState() => _ShowDreamScreenState();
}

class _ShowDreamScreenState extends State<ShowDreamScreen> with Helpers {
  @override
  void initState() {
    super.initState();
    _updateCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('تفاصيل الحلم'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Dream>>(
          stream: FbFireStoreController().readDreamDetails(id: widget.idDoc!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.all(15.0.w),
                child: Column(
                  children: [
                    CardDream(
                      trailing: Builder(builder: (context) {
                        return StreamBuilder<QuerySnapshot<Favorite>>(
                            stream: FbFavoriteController().readFavorite(widget.dream!.idDoc!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                return Visibility(
                                  visible: FbAuthController().loggedIn
                                      ? true
                                      : false,
                                  child: IconButton(
                                    onPressed: () async {
                                      snapshot.data!.docs.isEmpty
                                          ? _addFavoriteDream()
                                          : _deleteFavorite(
                                              path: widget.idDoc!);
                                    },
                                    icon: Icon(Icons.favorite,
                                        size: 30.h,
                                        color:  snapshot.data!.docs.isEmpty
                                            ? Colors.grey
                                            : Colors.red),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    '.',
                                    style: GoogleFonts.cairo(fontSize: 20.sp),
                                  ),
                                );
                              }
                            });
                      }),
                      dream: getDream(
                        snapshot.data!.docs[0],
                      ),
                    ),
                    Container(
                      // height: 200.h,
                      padding: EdgeInsets.all(14.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.blue.shade300),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.visibility_off,
                            size: 70.h,
                          ),
                          Text(
                            'البيانات الشخصية مخفية يتم مشاهدتها فقط بواسطة صاحب الحلم والمفسرين',
                            textAlign: TextAlign.center,
                            // overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: GoogleFonts.cairo(
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5.r),
                            spreadRadius: 2.r,
                            blurRadius: 3.r,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: 200.0.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0.w, vertical: 15.h),
                        child: ListView(
                          children: [
                            Text(
                              snapshot.data!.docs[0]
                                  .data()
                                  .replyMessage
                                  .toString(),
                              style: GoogleFonts.cairo(color: Colors.grey),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

  Future<void> _updateCounter() async {
    await FbFireStoreController().updateDreamCounter(
      IdDocDream: widget.idDoc!,
      counter: widget.counterDream!,
    );
  }

  Future<void> _updateFavorite(
      {required bool favorite,
      required String idFavorite,
      required int counter}) async {
    await FbFavoriteController().updateFavorite(
      counter: counter,
      isFavorite: favorite,
      IdDocDream: idFavorite,
    );
  }

  Future<void> _addFavoriteDream() async {
    FirebaseResponse firebaseResponse = await FbFavoriteController()
        .create(favorite: fav, idDocDream: fav.dreamId!);
  }

  Favorite get fav {
    Favorite favorite = Favorite(
        dreamId: widget.dream!.idDoc.toString(),
        Uid: FbAuthController().currentUser.uid);

    return favorite;
  }

  Future<void> _deleteFavorite({
    required String path,
  }) async {
    await FbFavoriteController().delete(path: path);
  }
}
