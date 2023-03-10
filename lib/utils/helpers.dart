import 'package:dream/models/process_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin Helpers {
  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.right,
        ),
        backgroundColor: !error ? Colors.green : Colors.red,

        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }ProcessResponse get failureResponse =>
      ProcessResponse("يوجد خطأ !! حاول مرة اخرى", true);

  ProcessResponse getAuthExceptionResponse(FirebaseAuthException e) {
    return ProcessResponse(e.message ?? "", true);
  }
}
