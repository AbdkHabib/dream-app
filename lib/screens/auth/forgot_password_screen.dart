import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/app_text_field.dart';
import 'package:dream/widgets/btn_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with Helpers {
  late TextEditingController _emailTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'استرجاع كلمة المرور',
              style: GoogleFonts.cairo(
                  color: const Color(0xff0B2E40), fontSize: 28.sp),
            ),
            Text(
              'سيتم أرسال رسالة نصية على البريد الالكتروني الذي ادخلته',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(color: Colors.blueGrey),
            ),
            SizedBox(
              height: 7.h,
            ),
            SizedBox(
              height: 38.h,
            ),
            AppTextField(
                textController: _emailTextController,
                hint: ' البريد الاكتروني'),
            SizedBox(
              height: 18.h,
            ),
            BtnAuth(
                title: 'ارسال', onPressed: () async => await _checkData()),
          ],
        ),
      ),
    );
  }

  bool _checkData() {
    if (_emailTextController.text.trim().isNotEmpty) {
      _forgotPassword();
      return true;
    }
    showSnackBar(context, message: 'أدخل البيانات بشكل صحيح !', error: true);
    return false;
  }

  Future<void> _forgotPassword() async {
    FirebaseResponse firebaseResponse = await FbAuthController().resetPassword(
      email: _emailTextController.text,
    );
    if (firebaseResponse.success) {
      Navigator.pop(context);
    }
    showSnackBar(context,
        message: firebaseResponse.massage, error: !firebaseResponse.success);
  }
}
