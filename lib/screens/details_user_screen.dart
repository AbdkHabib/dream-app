import 'dart:convert';

import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/models/marital_status.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/btn_auth.dart';
import 'package:dream/widgets/menu_details_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DetailsUserScreen extends StatefulWidget {
  DetailsUserScreen({
    Key? key,
    required this.detailsText,
    required this.titleText,
    // required Color backGroundColor
  }) :
  // _backGroundColor=backGroundColor,
        super(key: key);

  final String detailsText;
  final String titleText;

  @override
  State<DetailsUserScreen> createState() => _DetailsUserScreenState();
}

class _DetailsUserScreenState extends State<DetailsUserScreen> with Helpers {
  String mtoken = '';

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  final List<MaritalStatus> _maritalstatus = [
    const MaritalStatus(id: 1, name: 'اعزب / عزباء'),
    const MaritalStatus(id: 2, name: 'متزوج / متزوجة'),
    const MaritalStatus(id: 3, name: 'مطلق / مطلقة'),
    const MaritalStatus(id: 4, name: 'أرمل / أرملة'),
  ];
  final List<MaritalStatus> _age = [
    const MaritalStatus(id: 1, name: 'اقل من 18'),
    const MaritalStatus(id: 2, name: '18'),
    const MaritalStatus(id: 3, name: '19'),
    const MaritalStatus(id: 4, name: '20'),
    const MaritalStatus(id: 5, name: '21'),
    const MaritalStatus(id: 6, name: '22'),
    const MaritalStatus(id: 7, name: '23'),
    const MaritalStatus(id: 8, name: '24'),
    const MaritalStatus(id: 9, name: '25'),
    const MaritalStatus(id: 10, name: '26'),
    const MaritalStatus(id: 11, name: '27'),
    const MaritalStatus(id: 12, name: '28'),
    const MaritalStatus(id: 13, name: '29'),
    const MaritalStatus(id: 14, name: '30'),
    const MaritalStatus(id: 15, name: '31'),
    const MaritalStatus(id: 16, name: '32'),
    const MaritalStatus(id: 17, name: '33'),
    const MaritalStatus(id: 18, name: '34'),
    const MaritalStatus(id: 19, name: '35'),
    const MaritalStatus(id: 20, name: '36'),
    const MaritalStatus(id: 21, name: '37'),
    const MaritalStatus(id: 22, name: '38'),
    const MaritalStatus(id: 23, name: '39'),
    const MaritalStatus(id: 24, name: '40'),
    const MaritalStatus(id: 25, name: '41'),
    const MaritalStatus(id: 26, name: '42'),
    const MaritalStatus(id: 27, name: '43'),
    const MaritalStatus(id: 28, name: '44'),
    const MaritalStatus(id: 29, name: '45'),
    const MaritalStatus(id: 30, name: '46'),
    const MaritalStatus(id: 31, name: '47'),
    const MaritalStatus(id: 32, name: '48'),
    const MaritalStatus(id: 33, name: '49'),
    const MaritalStatus(id: 34, name: '50'),
    const MaritalStatus(id: 35, name: '51'),
    const MaritalStatus(id: 36, name: '52'),
    const MaritalStatus(id: 37, name: '53'),
    const MaritalStatus(id: 38, name: '54'),
    const MaritalStatus(id: 39, name: '55'),
    const MaritalStatus(id: 40, name: '56'),
    const MaritalStatus(id: 41, name: '57'),
    const MaritalStatus(id: 42, name: '58'),
    const MaritalStatus(id: 43, name: '59'),
    const MaritalStatus(id: 44, name: '60'),
    const MaritalStatus(id: 45, name: '60+'),
  ];
  final List<MaritalStatus> _gender = [
    const MaritalStatus(id: 1, name: 'ذكر'),
    const MaritalStatus(id: 2, name: 'انثى'),
  ];
  final List<MaritalStatus> _functionalStatus = [
    const MaritalStatus(id: 1, name: 'موظف / موظفة'),
    const MaritalStatus(id: 2, name: 'غير موظف / غير موظفة'),
  ];

  int? maritalstatusId;
  int? ageId;
  int? functionalStatusIndex;
  int? genderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('تفاصيل الحلم'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'الحالة الاجتماعية',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.lightBlueAccent),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w, vertical: 8.h),
                    child: DropdownButton<int>(
                      // itemHeight: 60,
                      underline: SizedBox(),
                      borderRadius: BorderRadius.circular(10.r),
                      dropdownColor: Colors.blue.shade100,
                      isExpanded: true,
                      onChanged: (int? value) {
                        setState(() => maritalstatusId = value);
                      },
                      value: maritalstatusId,
                      hint: Text('الحالة الاجتماعية'),
                      menuMaxHeight: 150.h,
                      items: _maritalstatus.map((MaritalStatus maritalstatus) {
                        return DropdownMenuItem<int>(
                          alignment: AlignmentDirectional.bottomEnd,
                          value: maritalstatus.id,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
                              child: Text(maritalstatus.name),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey, width: 1.w),
                                ),
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'اختر العمر',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.lightBlueAccent),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w, vertical: 8.h),
                    child: DropdownButton<int>(
                      // itemHeight: 60,
                      underline: SizedBox(),
                      borderRadius: BorderRadius.circular(10.r),
                      dropdownColor: Colors.blue.shade100,
                      isExpanded: true,
                      onChanged: (int? value) {
                        setState(() => ageId = value);
                      },
                      value: ageId,
                      hint: Text('العمر'),
                      menuMaxHeight: 150.h,
                      items: _age.map((MaritalStatus maritalstatus) {
                        return DropdownMenuItem<int>(
                          alignment: AlignmentDirectional.bottomEnd,
                          value: maritalstatus.id,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
                              child: Text(maritalstatus.name),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey, width: 1.w),
                                ),
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'حدد نوع الجنس',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.lightBlueAccent),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w, vertical: 8.h),
                    child: DropdownButton<int>(
                      // itemHeight: 60,
                      underline: SizedBox(),
                      borderRadius: BorderRadius.circular(10.r),
                      dropdownColor: Colors.blue.shade100,
                      isExpanded: true,
                      onChanged: (int? value) {
                        setState(() => genderId = value);
                      },
                      value: genderId,
                      hint: Text('الجنس'),
                      menuMaxHeight: 150.h,
                      items: _gender.map((MaritalStatus maritalstatus) {
                        return DropdownMenuItem<int>(
                          alignment: AlignmentDirectional.bottomEnd,
                          value: maritalstatus.id,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
                              child: Text(maritalstatus.name),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey, width: 1.w),
                                ),
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'الحالة الوظيفية',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.lightBlueAccent),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w, vertical: 8.h),
                    child: DropdownButton<int>(
                      // itemHeight: 60,
                      underline: SizedBox(),
                      borderRadius: BorderRadius.circular(10.r),
                      dropdownColor: Colors.blue.shade100,
                      isExpanded: true,
                      onChanged: (int? value) {
                        setState(() => functionalStatusIndex = value);
                      },
                      value: functionalStatusIndex,
                      hint: Text('الحالة الوظيفية'),
                      menuMaxHeight: 150.h,
                      items:
                      _functionalStatus.map((MaritalStatus maritalstatus) {
                        return DropdownMenuItem<int>(
                          alignment: AlignmentDirectional.bottomEnd,
                          value: maritalstatus.id,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
                              child: Text(maritalstatus.name),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey, width: 1.w),
                                ),
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                BtnAuth(
                    title: 'أرسال',
                    // onPressed: () {
                    //   Navigator.pushReplacementNamed(
                    //       context, '/details_user_screen');
                    // },
                    onPressed: () async => await _performAdd()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token!;
        print(token);
      });
    });
  }

  Future<void> _performAdd() async {
    if (_checkData()) {
      await _save();

      getToken();
    }
  }

  bool _checkData() {
    print(maritalstatusId);
    if (genderId != null &&
        functionalStatusIndex != null &&
        ageId != null &&
        maritalstatusId != null) {
      return true;
    }
    showSnackBar(context, message: 'أدخل البيانات بشكل صحيح !', error: true);
    return false;
  }

  Future<void> _save() async {
    await initPayment(
        amount: 200.0, context: context, email: FbAuthController().currentUser.email!);

  }



  Dream get dream {
    Dream dream = Dream(
      title: widget.titleText,
      description: widget.detailsText,
      replyMessage: '',
      isFavorite: true,
      functionalStatus: _functionalStatus
          .firstWhere((element) => element.id == functionalStatusIndex)
          .name,
      age: _age
          .firstWhere((element) => element.id == ageId)
          .name,
      gender: _gender
          .firstWhere((element) => element.id == genderId)
          .name,
      maritalstatus: _maritalstatus
          .firstWhere((element) => element.id == maritalstatusId)
          .name,
      token: mtoken,
      counter: 0,
    );
    dream.createdUid = '';
    return dream;
  }

  Future<void> initPayment({required String email,
    required double amount,
    required BuildContext context}) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(

          Uri.parse(
              'https://us-central1-debaj-ae4ba.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': amount.toString(),
          });
      print(response.statusCode);
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: jsonResponse['paymentIntent'],
            merchantDisplayName: 'Grocery Flutter course',
            customerId: jsonResponse['customer'],
            customerEphemeralKeySecret: jsonResponse['ephemeralKey'],

            // testEnv: true,
            // merchantCountryCode: 'SG',
          ));
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment is successful'),
        ),
      );
      FirebaseResponse firebaseResponse =
      await FbFireStoreController().create(dream: dream);
      showSnackBar(context,
          message: firebaseResponse.massage, error: false);

      Navigator.popUntil(
          context, (route) => route.settings.name == '/bottom_navigation_bar');
    } catch (error) {
      if (error is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occured ${error.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occured $error'),
          ),
        );
      }
    }
  }
}
