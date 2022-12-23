import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/bloc/login/sent_code/sent_code_bloc.dart';

class DialogOTP {
  static void showOTPDialog({
    required BuildContext context,
    required TextEditingController codeController,
    required String verificationID,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          "Enter OTP",
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: codeController,
              maxLength: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              log(verificationID);
              context
                  .read<SendOTPBloc>()
                  .add(SentCodeEvent(verificationID, codeController.text));
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}
