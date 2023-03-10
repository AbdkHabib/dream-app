import 'dart:developer';
import 'package:dream/firebase/fb_users_fire_sire_controller.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/models/process_response.dart';
import 'package:dream/models/users.dart';
import 'package:dream/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FbAuthController with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn(
    scopes: ['email'],
  );

  //SignIn, SignOut, CreateAccount, VerifyEmail, resetPassword
  static FbAuthController? _instance;

  FbAuthController._();

  factory FbAuthController() {
    return _instance ??= FbAuthController._();
  }

  Future<FirebaseResponse> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      log('create');
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();
      log('sendEmailVerification');
      await signOut();
      return FirebaseResponse(
        massage: 'تم الأنشاء, قم بمراجعة البريد الالكتروني الخاص بك للتفعيل',
        success: true,
      );
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.message!}');
      return FirebaseResponse(
        massage: e.message ?? '',
        success: false,
      );
    } catch (e) {
      log('catch: ${e.toString()}');

      return FirebaseResponse(
        massage: 'خطأ موجود, حاولة مرة اخرى',
        success: false,
      );
    }
  }

  Future<FirebaseResponse> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      bool verified = userCredential.user!.emailVerified;
      if (!verified) await _firebaseAuth.signOut();

      return FirebaseResponse(
          massage: verified
              ? 'تسجيل دخول ناجح'
              : 'تسجيل دخول خطاطئ, قم بتفعيل البريد الالكتروني الخاص بك!',
          success: verified);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(massage: e.message ?? '', success: false);
    } catch (e) {
      return FirebaseResponse(
        massage: 'خطأ موجود, حاولة مرة اخرى',
        success: false,
      );
    }
  }

  Future<FirebaseResponse> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      await _firebaseAuth.signOut();
      return FirebaseResponse(
        massage:
            'تم ارسال رسالة التفعيل , قم بمراجعة البريد الالكتروني الخاص بك للتفعيل',
        success: true,
      );
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(
        massage: e.message ?? '',
        success: false,
      );
    } catch (e) {
      return FirebaseResponse(
        massage: 'خطأ موجود, حاولة مرة اخرى',
        success: false,
      );
    }
  }

  Future<ProcessResponse?> signInWithGoogle() async {
    try {
      log('message');
      GoogleSignInAccount? googleUser = await _googleAuth.signIn();
      log('message 2');
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user != null) {
          await _saveUser(userCredential.user!);
          return ProcessResponse("Logged in successfully");
        }
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException');
      return getAuthExceptionResponse(e);
    } catch (e) {
      log('failureResponse');
      return failureResponse;
    }
  }

  Future<bool> _saveUser(User user) async {
    Users users =
        Users(userName: user.displayName ?? 'user', email: user.email ?? '');
    final response = await FbUsersFireStoreController().create(users: users);
    return response.success;
  }

  Future<void> signOut() async {
    try {
      await _googleAuth.signOut();
    } catch (e) {
      log(e.toString());
    }
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  bool get loggedIn => _firebaseAuth.currentUser != null;

  User get currentUser => _firebaseAuth.currentUser!;
}
