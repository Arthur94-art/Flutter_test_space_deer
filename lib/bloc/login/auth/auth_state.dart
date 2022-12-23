part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedSuccessState extends AuthState {
  final String verificationId;
  AuthLoadedSuccessState(this.verificationId);
}

class ShowButtonState extends AuthState {
  final bool isShowButton;
  ShowButtonState(this.isShowButton);
}

class AuthFaliureState extends AuthState {
  String errorMessage;
  AuthFaliureState(this.errorMessage);
}
