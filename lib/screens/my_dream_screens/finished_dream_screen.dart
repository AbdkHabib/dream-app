import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/screens/show_dream_screen.dart';
import 'package:dream/widgets/card_dream.dart';
import 'package:dream/widgets/listview_my_dream.dart';
import 'package:dream/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishedDreamScreen extends StatelessWidget {
  const FinishedDreamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Dream>>(
          stream: FbFireStoreController().readFinishedDream(),
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
    );
  }

  Dream getDream(QueryDocumentSnapshot<Dream> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }
}
