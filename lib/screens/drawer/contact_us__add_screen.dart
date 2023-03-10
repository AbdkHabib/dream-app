import 'dart:convert';

import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/firebase/fb_commenter_fire_store_controller.dart';
import 'package:dream/firebase/fb_connect_fire_store_controller.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/connect.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/app_text_field.dart';
import 'package:dream/widgets/btn_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ContactUsAddScreen extends StatefulWidget {
  const ContactUsAddScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactUsAddScreen> createState() => _ContactUsAddScreenState();
}

class _ContactUsAddScreenState extends State<ContactUsAddScreen> with Helpers {
  late TextEditingController _titleTextController;
  late TextEditingController _detailsTextController;

  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController();
    _detailsTextController = TextEditingController();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _detailsTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Center(
          child: Text('اضافة تعليق'),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.all(20.0.w),
            child: Column(
              children: [
                AppTextField(
                  textController: _titleTextController,
                  hint: 'عنوان الرسالة ',
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: const Color(0xffB4CDE6),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(8.0.w),
                    child: Text(
                      'أرفق شكوى أو أقتراح لمسؤولي التطبيق',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        color: const Color(0xff628E90),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
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
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (text) => setState(() {}),
                ),
                 SizedBox(
                  height: 15.h,
                ),
              BtnAuth(title: 'اضافة رسالة', onPressed: _performAdd),
              ],
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13.w),
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }

  Future<void> _performAdd() async {
    if (_checkData()) {
      await _save();
      // _updateCounter();
    }
  }

  bool _checkData() {
    if (_detailsTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'أدخل البيانات بشكل صحيح !', error: true);
    return false;
  }

  Future<void> _save() async {
    if(FbAuthController().loggedIn){
      FirebaseResponse firebaseResponse =
      await FbConnectFireStoreController().create(connect: connect);
      showSnackBar(context,
          message: firebaseResponse.massage, error: !firebaseResponse.success);
      Navigator.pop(context);
    }else{
      showSnackBar(context, message: ' لم يتم تنفيذ العملية بنجاح يجب تسجيل الدخول في التطبيق اولاً ',error: true );

    }

  }

  Connect get connect {
    Connect connect = Connect(
      title: _titleTextController.text,
      description: _detailsTextController.text,
    );

    return connect;
  }
}
