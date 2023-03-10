import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/commenter.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/widgets/card_dream.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'show_dream_commentator_screen.dart';

class CommentatorHomeScreen extends StatefulWidget {
  const CommentatorHomeScreen({
    Key? key,
    required this.commenter,
    // this.idCommenter,
    // this.counterCommenter,

    // required Color backGroundColor
  }) :
        // _backGroundColor=backGroundColor,
        super(key: key);
  // final String? idCommenter;
  // final int? counterCommenter;
  final Commenter commenter;

  @override
  State<CommentatorHomeScreen> createState() => _CommentatorsScreenState();
}

class _CommentatorsScreenState extends State<CommentatorHomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Center(child: Text('المفسرين')),

      ),
      body: StreamBuilder<QuerySnapshot<Dream>>(
          stream: FbFireStoreController().readAllDreamCommenter(),
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
                            builder: (context) => ShowDreamCommentatorScreen(
                              dream: snapshot.data!.docs[index].data(),
                            commenter: widget.commenter,
                            ),
                          ),
                        );
                      },
                      child: Padding(

                        padding:  EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 15.h),
                        child: CardDream(
                          trailing: Text(''),
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
    );
  }

  Dream getDream(QueryDocumentSnapshot<Dream> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }
}
