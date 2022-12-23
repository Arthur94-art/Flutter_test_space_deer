part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthRequestEvent extends AuthEvent {
  final String phoneNumber;
  AuthRequestEvent(this.phoneNumber);
}

class AuthSuccessEvent extends AuthEvent {
  final String verificationID;
  AuthSuccessEvent(this.verificationID);
}

class ShowButtonEvent extends AuthEvent {
  final bool isShowButton;
  ShowButtonEvent(this.isShowButton);
}

class AuthErrorEvent extends AuthEvent {
  final String error;
  AuthErrorEvent(this.error);
}
