import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/firebase/fb_fire_store_controller.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/screens/details_user_screen.dart';
import 'package:dream/utils/helpers.dart';
import 'package:dream/widgets/app_text_field.dart';
import 'package:dream/widgets/btn_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDreamScreen extends StatefulWidget {
  const AddDreamScreen({Key? key}) : super(key: key);

  @override
  State<AddDreamScreen> createState() => _AddDreamScreenState();
}

class _AddDreamScreenState extends State<AddDreamScreen> with Helpers {
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
        title: Center(
          child: Text('ادخال الحلم'),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 20.h),
            child: Column(
              children: [
                AppTextField(
                  textController: _titleTextController,
                  hint: 'عنوان الحلم ',
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Color(0xffB4CDE6),
                  ),
                  child: Text(
                    'الرجاء كتابة حلمك بشكل مفصل بتضمن تفاصيل الحلم, وقت الحلم,ماهي الحالة الدينية لك ,هل يوجد حمل او في انتظار حمل , هل هناك ارق وهموم قبل النوم , هل قمت بترقية شرعية , هل كان الحلم استخارة وما هي',
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
                    hintText: '...ادخل الحلم بالكامل',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) => setState(() {}),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BtnAuth(
                  title: 'التالي',
                  onPressed: ()async=> await _performLogin()
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

  // bool get isNewProduct => widget == null;
  //
  Future<void> _performLogin() async {
    if (_checkData()) {
      await _save();
    }
  }

  bool _checkData() {
    if (_titleTextController.text.isNotEmpty &&
        _detailsTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'أدخل البيانات بشكل صحيح !', error: true);
    return false;
  }

  Future<void> _save() async {
    // _clear();
    Navigator.push(context,  MaterialPageRoute(
        builder: (context) => DetailsUserScreen(
      titleText: _titleTextController.text,
      detailsText: _detailsTextController.text,
    ),),);
// _clear();
  }

  void _clear() {
    _titleTextController.clear();
    _detailsTextController.clear();
  }
  //
  // Dream get dream {
  //   Dream dream = Dream(
  //        _titleTextController.text,
  //        _detailsTextController.text);
  //   return dream;
  // }

}
