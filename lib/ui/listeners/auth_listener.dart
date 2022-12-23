import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/bloc/login/auth/auth_bloc.dart';
import 'package:test_space_deer/utils/dialog_otp.dart';
import 'package:test_space_deer/utils/snack_bar.dart';

class AuthListener {
  static BlocListener getAuthListener(
    BuildContext context,
    TextEditingController otpController,
  ) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadedSuccessState &&
            state.verificationId.isNotEmpty) {
          DialogOTP.showOTPDialog(
            codeController: otpController,
            context: context,
            verificationID: state.verificationId,
          );
        }
        if (state is AuthFaliureState && state.errorMessage.isNotEmpty) {
          ToastMessage().showSnackBar(context, state.errorMessage);
        }
      },
    );
  }
}
