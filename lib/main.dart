import 'package:dream/firebase/FbNotifications.dart';
import 'package:dream/screens/add_dream_screen.dart';
import 'package:dream/screens/admin_screens/add_accounts_screen.dart';
import 'package:dream/screens/auth/login_screen.dart';
import 'package:dream/screens/bottom_navigation_bar.dart';
import 'package:dream/screens/home_screen.dart';
import 'package:dream/screens/my_dream_screens/my_dream_tab.dart';
import 'package:dream/screens/show_dream_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'screens/admin_screens/admin_home_screen.dart';
import 'screens/admin_screens/all_dream_screen.dart';
import 'screens/admin_screens/users_account_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/drawer/about_screen.dart';
import 'screens/drawer/contact_us__add_screen.dart';
import 'screens/launch_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51LwTvbGtf5KhkDXmb0o30fF2hRZ2VJv3nI1UCY99YdJSK7p6RnWNkJuo0sZDITawpkYt4FNXBRRzXGNPOqf2Ufle00MTvPyjD0";
  Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await FbNotifications.initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 830),
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white, size: 20.h),
                toolbarHeight: 81.h,
                backgroundColor: Color(0XFF28A9E1),
                titleTextStyle: GoogleFonts.ubuntu(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                elevation: 0,
              ),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const LaunchScreen(),
              '/login_screen': (context) => const LoginScreen(),
              '/home_screen': (context) => const HomeScreen(),
              '/add_dream_screen': (context) => const AddDreamScreen(),
              '/forgot_password_screen': (context) => const ForgotPassword(),
              '/register_screen': (context) => const RegisterScreen(),
              '/bottom_navigation_bar': (context) =>
                  const BottomNavigationScreen(),
              '/my_dream_screen': (context) => const MyDreamScreen(),
              '/show_dream_screen': (context) => const ShowDreamScreen(),
              '/admin_home_screen': (context) => const AdminHomeScreen(),
              '/all_dream_screen': (context) => const AllDreamScreen(),
              '/add_accounts_screen': (context) => const AddAccountsScreen(),
              '/users_account_screen': (context) => const UsersAccountScreen(),
              '/about_screen': (context) => const AboutScreen(),
              '/contact_us_add_screen': (context) => const ContactUsAddScreen(),
            },
          );
        });
  }
}
