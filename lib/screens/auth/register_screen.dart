import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/firebase/fb_users_fire_sire_controller.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/models/users.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/app_text_field.dart';
import 'package:dream/widgets/btn_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _userNameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _userNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تسجيل مستخدم جديد',
                  style: GoogleFonts.nunito(
                      color: const Color(0xff0B2E40), fontSize: 28.sp),
                ),
                Container(
                  padding: EdgeInsets.only(left: 69.w, right: 69.w),
                  child: Text(
                    'ادخل الايميل  الخاص بدك , سوف تستلم في بريدك الخاص رسالة تفعيل',
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: GoogleFonts.nunito(
                      color: const Color(0xff7E7B7B),
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTextField(
                    textController: _userNameTextController,
                    hint: 'الاسم الشخصي'),
                SizedBox(
                  height: 16.h,
                ),
                AppTextField(
                  textController: _emailTextController,
                  hint: 'البريد الاكتروني',
                ),
                SizedBox(
                  height: 16.h,
                ),
                AppTextField(
                    obscureText: true,
                    textController: _passwordTextController,
                    hint: 'كلمة المرور'),
                SizedBox(
                  height: 20.h,
                ),
                BtnAuth(
                  title: 'تسجيل',
                  onPressed: () async => await _performRegister(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_userNameTextController.text.trim().isNotEmpty &&
        _emailTextController.text.trim().isNotEmpty &&
        _passwordTextController.text.trim().isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'ادخل المعلومات بشكل صحيح!', error: true);
    return false;
  }

  Future<void> _register() async {


    FirebaseResponse firebaseResponse = await FbAuthController().createAccount(
        email: _emailTextController.text,
        password: _passwordTextController.text);

    if (firebaseResponse.success) {
      await FbUsersFireStoreController().create(users: users);
      Navigator.pop(context);
    }
    showSnackBar(context, message: firebaseResponse.massage,error: !firebaseResponse.success);
  }

  Users get users {
    Users users = Users(
      email: _emailTextController.text,
      userName: _userNameTextController.text,
    );
    return users;
  }
}
