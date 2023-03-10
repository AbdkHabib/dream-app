import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/screens/show_dream_screen.dart';
import 'package:dream/widgets/card_dream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewMyDream extends StatelessWidget {
  const ListViewMyDream({Key? key ,required this.dream,

  }) :
        super(key: key);

  final Dream dream;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDreamScreen(
              dream: dream,
            ),
          ),
        );
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 15.h),
        child: CardDream(
          trailing: Text(''),
          dream: dream,
        ),
      ),
    );
  }
  Dream getDream(QueryDocumentSnapshot<Dream> queryDocumentSnapshot) {
    queryDocumentSnapshot.data().idDoc = queryDocumentSnapshot.id;
    return queryDocumentSnapshot.data();
  }
}
