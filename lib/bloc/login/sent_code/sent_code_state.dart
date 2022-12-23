part of 'sent_code_bloc.dart';

abstract class SentOTPState {}

class SentCodeInitialState extends SentOTPState {}

class SentCodeSuccessState extends SentOTPState {
  final String userData;
  SentCodeSuccessState(this.userData);
}

class SentCodeFailureState extends SentOTPState {
  final String errorMessage;
  SentCodeFailureState(this.errorMessage);
}
