import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/bloc/login/sent_code/sent_code_bloc.dart';
import 'package:test_space_deer/ui/home.dart';
import 'package:test_space_deer/utils/snack_bar.dart';

class OTPListener {
  static BlocListener getOTPListener(BuildContext context) {
    return BlocListener<SendOTPBloc, SentOTPState>(listener: (context, state) {
      if (state is SentCodeInitialState) {
        const CircularProgressIndicator();
      }
      if (state is SentCodeSuccessState &&
          state.userData.user?.uid.isNotEmpty as bool) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
      if (state is SentCodeFailureState && state.errorMessage.isNotEmpty) {
        Navigator.pop(context);
        ToastMessage().showSnackBar(context, state.errorMessage);
      }
    });
  }
}
