import 'package:dream/models/dream.dart';
import 'package:dream/widgets/icon_dream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CardDream extends StatelessWidget {
  const CardDream({
    Key? key,
    required this.dream,
    required Widget trailing,
  }) :      _trailing = trailing,
        super(key: key);

  final Dream dream;
  final Widget _trailing;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            color: Colors.white,
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 20.h),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              _trailing,

                              Flexible(
                                child: RichText(

                                  strutStyle:  StrutStyle(fontSize: 12.0.sp),
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.black),
                                    text: '  تفسير حلم ${dream.title}',
                                  ),
                                ),
                              ),

                            ],
                          ),
                      SizedBox(
                        height: 15.h,
                      ),

                          Text(
                            dream.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cairo(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const Divider(height: 5),
                           SizedBox(
                            height: 4.h,
                          ),
                        ],
                      ),
                    ),
                     SizedBox(
                      width: 16.w,
                    ),
                    const IconDream(),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      dream.counter.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                     SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      ': مشاهدة',
                      style: GoogleFonts.cairo(

                        fontSize: 14.sp,
                      ),
                    ),
                     SizedBox(
                      width: 5.w,
                    ),
                    const Icon(Icons.remove_red_eye),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          DateFormat.yMd().add_jm().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  dream.createdDate,
                                ),
                              ),
                        ),
                      ],
                    ),
                    const Icon(Icons.calendar_month_outlined),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
