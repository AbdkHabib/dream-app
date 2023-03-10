import 'dart:developer';

import 'package:dream/firebase/fb_commenter_fire_store_controller.dart';
import 'package:dream/models/commenter.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/app_text_field.dart';
import 'package:dream/widgets/btn_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAccountsScreen extends StatefulWidget {
  const AddAccountsScreen({Key? key}) : super(key: key);

  @override
  State<AddAccountsScreen> createState() => _AddAccountsScreenState();
}

class _AddAccountsScreenState extends State<AddAccountsScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _userNameTextController;
  late TextEditingController _phoneNumberTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _userNameTextController = TextEditingController();
    _phoneNumberTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _userNameTextController.dispose();
    _phoneNumberTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'أضافة مفسرين',
            style: GoogleFonts.cairo(fontSize: 20),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ': الاسم بالكامل',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _userNameTextController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[أ-ي,a-z, ]'),
                    ),
                    LengthLimitingTextInputFormatter(30),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  ': رقم الهاتف',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _phoneNumberTextController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                    LengthLimitingTextInputFormatter(12),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  ': البريد الالكتروني',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _emailTextController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  ': كلمة المرور',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _passwordTextController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),

                  ],obscureText: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _performLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.red,

                    minimumSize: Size(double.infinity, 48.h),
                  ),
                  child: Text(
                    'اضافة',
                    style: GoogleFonts.ubuntu(
                      fontSize: 18,
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
        width: 1,
        color: color,
      ),
    );
  }

  Future<void> _performLogin() async {
    if (_checkData()) {
      await _save();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _userNameTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _phoneNumberTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'أدخل البيانات بشكل صحيح !', error: true);
    return false;
  }

  Future<void> _save() async {
    FirebaseResponse firebaseResponse =
        await FbCommenterFireStoreController().create(commenter: commenter);
    showSnackBar(context,
        message: firebaseResponse.massage, error: !firebaseResponse.success);
    Navigator.popUntil(
        context, (route) => route.settings.name == '/admin_home_screen');
  }

  Commenter get commenter {
    Commenter commenter = Commenter(
      email: _emailTextController.text,
      phoneNumber: _phoneNumberTextController.text,
      userName: _userNameTextController.text,
      password: _passwordTextController.text,
      counter: 0,
    );

    return commenter;
  }
}
