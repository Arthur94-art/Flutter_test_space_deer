part of 'sent_code_bloc.dart';

abstract class SentOTPEvent {}

class SentCodeEvent extends SentOTPEvent {
  final String verificationId;
  final String controllerText;
  SentCodeEvent(this.verificationId, this.controllerText);
}

class SendCodeSuccessEvent extends SentOTPEvent {
  final UserCredential userData;
  SendCodeSuccessEvent(this.userData);
}

class SendCodeErrorEvent extends SentOTPEvent {
  final String errorMessage;
  SendCodeErrorEvent(this.errorMessage);
}
