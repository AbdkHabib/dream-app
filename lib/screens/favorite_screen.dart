import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_favorite_controller.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/models/favorite.dart';
import 'package:dream/widgets/card_dream.dart';
import 'package:dream/widgets/icon_dream.dart';
import 'package:dream/widgets/listview_my_dream.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'show_dream_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'المفضلة',
          ),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Favorite>>(
          stream: FbFavoriteController().readMyFavorite(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingScreen(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {

              return Builder(builder: (context) {
                log('${snapshot.data!.docs.map((e) => e.data().dreamId).toList()}');
                return StreamBuilder<QuerySnapshot<Dream>>(

                    stream: FbFavoriteController().readDream(id: snapshot.data!.docs
                        .map((e) => e.data().dreamId)
                        .toList()

                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: LoadingScreen(),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
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
                                        dream:
                                            snapshot.data!.docs[index].data(),
                                        idDoc: snapshot.data!.docs[index]
                                            .data()
                                            .idDoc,
                                        counterDream: snapshot.data!.docs[index]
                                            .data()
                                            .counter,
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
                            'لم تقم بارفاق اي حلم',
                            style: GoogleFonts.cairo(fontSize: 20.sp),
                          ),
                        );
                      }
                    });
              });
            } else {
              return Center(
                child: Text(
                  'لم تقم بالاعجاب باي حلم',
                  style: GoogleFonts.cairo(fontSize: 20.sp),
                ),
              );
            }
          }),
    );
  }

  Dream getDream(QueryDocumentSnapshot<Dream> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }
}
