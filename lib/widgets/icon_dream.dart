import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconDream extends StatelessWidget {
  const IconDream({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0.r,
            offset: Offset(
                0, 0), // changes position of shadow
          ),
        ],
      ),
      child:  Image(
        image: AssetImage('images/dream-logo.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}