import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_commenter_fire_store_controller.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/commenter.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AddReplyScreen extends StatefulWidget {
  const AddReplyScreen({
    Key? key,
    required this.idDream,
    this.commenter,
    this.dream,

    // required Color backGroundColor
  }) :
        // _backGroundColor=backGroundColor,
        super(key: key);
  final String idDream;
  final Commenter? commenter;
  final Dream? dream;

  @override
  State<AddReplyScreen> createState() => _AddReplyScreenState();
}

class _AddReplyScreenState extends State<AddReplyScreen> with Helpers {
  late TextEditingController _detailsTextController;

  @override
  void initState() {
    super.initState();
    _detailsTextController = TextEditingController();
  }

  @override
  void dispose() {
    _detailsTextController.dispose();
    _updateFlag();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.dream!.token);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Center(
          child: Text('اضافة رد'),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 20.h),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Color(0xffB4CDE6),
                  ),
                  child: Text(
                    'الرجاء كتابة تفسير الحلم بالكامل لان الرد لمرة واحدة ولن تتمكن من اضافة رد ثاني فراعي كتابة الرد بالتفصيل لتجنب اي مشاكل في ما بعد.وشكراً',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      color: Color(0xff628E90),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  textAlign: TextAlign.right,
                  controller: _detailsTextController,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    enabledBorder:
                        buildOutlineInputBorder(color: const Color(0xFFB9E0FF)),
                    focusedBorder:
                        buildOutlineInputBorder(color: const Color(0xFF8D72E1)),
                    hintText: '...ادخل الرد بالكامل',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) => setState(() {}),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _performAdd();
                  },
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      ),
                    ),
                    elevation: 0,
                    primary: Colors.lightGreen,
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
      ),
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

  Future<void> _performAdd() async {
    if (_checkData()) {
      await _save();
      _updateCounter();
      await sendPushMessage();
    }
  }

  bool _checkData() {
    if (_detailsTextController.text.isNotEmpty &&
        _detailsTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'أدخل البيانات بشكل صحيح !', error: true);
    return false;
  }

  Future<void> _save() async {
    FirebaseResponse firebaseResponse = await FbFireStoreController().update(
        replyString: _detailsTextController.text, IdDocDream: widget.idDream);
    showSnackBar(context,
        message: firebaseResponse.massage, error: !firebaseResponse.success);

    // Navigator.pushNamed(context, '/bottom_navigation_bar');
    if (firebaseResponse.success) {
      Navigator.pop(context);
    }
  }

//update counter +1
  Future<void> _updateCounter() async {
    await FbCommenterFireStoreController().updateCounter(
      IdDocDream: widget.commenter!.idDoc!,
      counterCommenter: widget.commenter!.counter,
    );
  }


  Future<void> sendPushMessage() async {
      try {
     var response =await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=	AAAARSiRxI8:APA91bHU5qzwx4z3ckwZJZSFcwkvmM3G1Eadxbom_8YcWyX28mzSziR45AWzSWNih595wfChnZmSHDB3hlJ-HbDv26FujPLWoNBL40DszQ1RhhF3m_XTc0xo0WmQBYi3ZE0WlGBrNvgM'
        },
        body: jsonEncode({
          'registration_ids': [widget.dream!.token],
          'data': {
            'via': 'FlutterFire Cloud Messaging!!!',
            'count': '1',
          },
          'notification': {
            'title': 'ديباج',
            'body':  'تم الرد على حلم قمت بأرفاقه, الرجاء مراجعة التطبيق',
          },
        }),
      );
     print(response.statusCode);
    } catch (e) {

      print(e);
    }
  }
  Future<void> _updateFlag() async {
    await FbFireStoreController()
        .updateFlagBtnCommenter(IdDocDream: widget.dream!.idDoc!);
  }
}
