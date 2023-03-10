import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
              )),
          title: const Center(child: Text('حول التطبيق')),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding:  EdgeInsets.all(15.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'تفسير الاحلام المباشر - هل شاهدت حلم أو رؤيا و ترغب في تفسيرها ؟ احصل على تفسير الحلم من خبرائنا الذين لديهم خبرة طويلة في تفسير الأحلام على الطريقة الدينية.اكتب الحلم أو الرؤيا التي حلمت به واحصل على تفسير حلمك على سيرة ابن سيرين أو النابلسي و غيرهم من المفسرين .بإمكانكم استشارة مفسري الأحلام المتوفرين على مدار اليوم لتفسير الأحلام التي تريدونها .. كما نوفر لكم طلب تفسير حلم بشكل مستعجل بقيمة 12 ريال سعودي / درهم امارتي فقط',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        color: Colors.grey.shade500,
                      ),
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'سؤال وجواب',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                      indent: 30,
                    ),
                    Text(
                      'ما هو الجد يد في هذه النسخة من التطبيق ؟',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      ' تم اضافة خاصية التسجيل .. حيث تستطيع الان التسجيل في التطبيق مما يعني عدم فقدان احلامك و الاحلام المفضلة عند تحديث التطبيق او عند تغيير جهازك - تحسين طريقة عرض احلامك المفسرة والغير مفسرة - اضافة خيار دفع جديد .',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                      indent: 30,
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'كيف يعمل تطبيق الاحلام المباشر ؟',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      ' يعتبر تفسير الاحلام المباشر منصة للتواصل المباشر بين أصحاب الاحلام وبين مختصي التفسير والتأويل ، حيث يستطيع مستخدم التطبيق استعراض ومشاهدة الاحلام المفسرة مسبقا ، كما يستطيعوا ان يرسل طلب تفسیر خاص باحلامهم .',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                      indent: 30,
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'كم المدة المتوقعة للحصول على تفسير لحلمك ؟',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      ' نعمل بكل اخلاص على ان يتم الرد وتفسير الاحلام خلال الفترات المحددة لكل نوع من الاحلام ، الرد على الاحلام المجانية قد يستغرق وقت طويل نظرا لكثرة الطلبات .',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                      indent: 30,
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      ' هل هناك طريقة للحصول على تفسير الحلم بأسرع وقت ممكن ؟',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      ' نعم ممكن ، نحن نقدم إمكانية طلب تفسير الحلم بسرعة وفي هذه الحالة يتم تفسير الحلم خلال 12 ساعة عمل او اقل . وللعلم فان التفسير المستعجل عبارة عن خدمة مدفوعة الثمن وهي بسعر رمزي 15 ريال سعودي / درهم امارتي او ما يعادلها من العملات الاخرى .',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                      indent: 30,
                    ),
                    Text(
                      '  من هم المفسرون والمفسرات ؟',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      ' يضم فريق العمل لدينا خبراء مختصين من المفسرين والمفسرات الذين',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        color: Colors.grey.shade500,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
