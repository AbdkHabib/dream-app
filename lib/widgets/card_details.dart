import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({
    Key? key,
    required String staticTitle,
    required String title,
  })  :
        _staticTitle = staticTitle,
        _title = title,
        super(key: key);
  final String _staticTitle;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.r,
            blurRadius: 3.r,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _title,
              style: GoogleFonts.cairo(
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              _staticTitle,
              style: GoogleFonts.cairo(
                  fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
