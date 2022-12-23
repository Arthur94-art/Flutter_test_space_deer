import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/bloc/login/auth/auth_bloc.dart';
import 'package:test_space_deer/bloc/login/sent_code/sent_code_bloc.dart';

import 'package:test_space_deer/ui/listeners/auth_listener.dart';
import 'package:test_space_deer/ui/listeners/otp_listener.dart';
import 'package:test_space_deer/ui/widgets/custom_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneController =
      TextEditingController(text: '+380');
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      AuthListener.getAuthListener(context, _otpController),
      OTPListener.getOTPListener(context),
    ], child: CustomTextField(phoneController: _phoneController));
  }
}
