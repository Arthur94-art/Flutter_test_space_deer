import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/data/repository/sent_code_repo.dart';

part 'sent_code_event.dart';
part 'sent_code_state.dart';

class SendOTPBloc extends Bloc<SentOTPEvent, SentOTPState> {
  final SentCodeRepository _sentCodeRepository = SentCodeRepository();
  late final StreamSubscription _errorSubscription;
  late final StreamSubscription _userDataSubscription;

  SendOTPBloc() : super(SentCodeInitialState()) {
    _userDataSubscription = _sentCodeRepository.userData.listen((userData) {
      add(SendCodeSuccessEvent(userData));
    });
    _errorSubscription =
        _sentCodeRepository.errorMessage.listen((errorMessage) {
      add(SendCodeErrorEvent(errorMessage));
    });
    on<SentCodeEvent>(_sendCodeEventHandler);
    on<SendCodeSuccessEvent>(_sendCodeSuccessEventHandler);
    on<SendCodeErrorEvent>(_sendCodeErrorEventHandler);
  }
  Future<void> _sendCodeEventHandler(SentCodeEvent event, emit) async {
    await _sentCodeRepository.sentCode(
        event.verificationId, event.controllerText);
  }

  void _sendCodeSuccessEventHandler(SendCodeSuccessEvent event, emit) {
    emit(SentCodeSuccessState(event.userData));
  }

  void _sendCodeErrorEventHandler(SendCodeErrorEvent event, emit) {
    emit(SentCodeFailureState(event.errorMessage));
  }

  @override
  Future<void> close() {
    _userDataSubscription.cancel();
    _errorSubscription.cancel();
    _sentCodeRepository.close();
    return super.close();
  }
}
