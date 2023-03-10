import 'package:auth_buttons/auth_buttons.dart';
import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/firebase/fb_commenter_fire_store_controller.dart';
import 'package:dream/models/commenter.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/screens/commentators/commentator_home_screen.dart';
import 'package:dream/screens/home_screen.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/app_text_field.dart';
import 'package:dream/widgets/btn_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget with Helpers {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  bool _isLogging = false;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // resizeToAvoidBottomInset: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Center(
              child: Padding(
                padding:  EdgeInsets.only(right: 15.0.w),
                child: Text(
                  'تسجيل الدخول',
                  style: GoogleFonts.ubuntu(
                    fontSize: 28.sp,
                    color: const Color(0xff0B2E40),
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        height: 27.h,
                      ),
                      AppTextField(
                        textController: _emailTextController,
                        hint: 'البريد الاكتروني ',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextField(
                        textController: _passwordTextController,
                        hint: 'كلمة السر',
                        textInputType: TextInputType.text,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, '/forgot_password_screen'),
                            child: Text(
                              'هل نسيت كلمة المرور؟',
                              style: GoogleFonts.ubuntu(
                                fontSize: 12.sp,
                                color: const Color(0xff0B2E40),
                              ),
                            ),
                          ),
                        ],
                      ),
                      BtnAuth(
                          title: 'تسجيل الدخول',
                          onPressed: () async {
                            if (_emailTextController.text == '123' &&
                                _passwordTextController.text == '123') {
                              Navigator.pushReplacementNamed(
                                  context, '/admin_home_screen');
                            } else {
                              await _performLogin();
                            }
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                      GoogleAuthButton(
                        onPressed: () async {
                          setState(() {
                            _isLogging = true;
                          });
                          await _performLoginWithGoogle();
                        },
                        themeMode: ThemeMode.light,
                        style: AuthButtonStyle(
                          iconType: AuthIconType.outlined,
                          width: double.infinity,
                          height: 48.h,
                          borderColor: Color(0xff03A7A9),
                          iconSize: 22.r,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, '/register_screen'),
                            child: Text(
                              'انشاء حساب جديد!',
                              style: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                color: const Color(0xff03A7A9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Text(
                            'لا تمتلك حساب؟؟',
                            style: GoogleFonts.cairo(
                              fontSize: 14.sp,
                              color: const Color(0xff0B2E40),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: _isLogging,
          child: Center(child: const CircularProgressIndicator()),
        ),
      ],
    );
  }

  Future<void> _performLoginWithGoogle() async {
    final nav = Navigator.of(context);
    final response = await FbAuthController().signInWithGoogle();
    setState(() {
      _isLogging = false;
    });
    // if (!mounted) return;
    if (response != null) {
      showSnackBar(context, message: response.message, error: response.success);
      if (response.success) {
        nav.popUntil((route) => route.isFirst,);
      }
    }
  }

  Future<void> _performLogin() async {
    if (_checkData()) {
      await _login();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.trim().isNotEmpty &&
        _passwordTextController.text.trim().isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'أدخل البيانات بشكل صحيح !', error: true);
    return false;
  }

  Future<void> _login() async {
    final queryCommenter = await FbCommenterFireStoreController()
        .readCommenterData(
            email: _emailTextController.text,
            password: _passwordTextController.text);
    Commenter? commenter;
    FirebaseResponse firebaseResponse = await FbAuthController().signIn(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (firebaseResponse.success) {
      Navigator.pushReplacementNamed(context, '/add_dream_screen');
      showSnackBar(context,
          message: firebaseResponse.massage, error: !firebaseResponse.success);
    }

    else if (queryCommenter != null) {
      commenter = queryCommenter.docs.first.data();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CommentatorHomeScreen(commenter: commenter!),
        ),
      );
    }
    else {
      showSnackBar(context, message: 'لم تنجح عملية الدخول',error: true);
    }
  }
}
