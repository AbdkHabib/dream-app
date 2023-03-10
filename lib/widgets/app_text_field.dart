import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required TextEditingController textController,
    required String hint,
    TextInputType textInputType = TextInputType.text,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.next,
    Function(String value)? onSubmitted,
  })  : _textController = textController,
        _hint = hint,
        _textInputType = textInputType,
        _obscureText = obscureText,
        _textInputAction = textInputAction,
        _onSubmitted = onSubmitted,
        super(key: key);

  final TextEditingController _textController;
  final String _hint;
  final TextInputType _textInputType;
  final bool _obscureText;
  final TextInputAction _textInputAction;
  final void Function(String value)? _onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 30,
      textAlign: TextAlign.right,
      controller: _textController,
      keyboardType: _textInputType,
      textInputAction: _textInputAction,
      onSubmitted: _onSubmitted,
      obscureText: _obscureText,
      style: GoogleFonts.nunito(),
      decoration: InputDecoration(
        hintText: _hint,
        hintStyle: GoogleFonts.nunito(),
        enabledBorder: buildOutlineInputBorder(color: const Color(0xFFB9E0FF)),
        focusedBorder: buildOutlineInputBorder(color: const Color(0xFF8D72E1)),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13.r),
      borderSide: BorderSide(
        width: 2.w,
        color: color,
      ),
    );
  }
}
