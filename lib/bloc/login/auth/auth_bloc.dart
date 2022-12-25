import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  late final StreamSubscription _verificationSubscription;
  late final StreamSubscription _errorSubscription;
  late final StreamSubscription _showLoadingSubscription;
  AuthBloc() : super(AuthLoadingState()) {
    _verificationSubscription =
        _authRepository.verificationID.listen((verificationID) {
      add(AuthSuccessEvent(verificationID));
    });

    _errorSubscription = _authRepository.errorMessage.listen((errorMessage) {
      add(AuthErrorEvent(errorMessage));
    });
    _showLoadingSubscription =
        _authRepository.isShowLoading.listen((isShowLoading) {
      add(ShowButtonEvent(isShowLoading));
    });
    on<AuthRequestEvent>(_authRequestEventHandler);
    on<AuthSuccessEvent>(_authRequestSuccessHandler);
    on<AuthErrorEvent>(_authRequestErrorHandler);
    on<ShowButtonEvent>(_isShowButtonHandler);
  }

  Future<void> _authRequestEventHandler(AuthRequestEvent event, emit) async {
    await _authRepository.signUpWithPhone(event.phoneNumber);
  }

  void _authRequestSuccessHandler(AuthSuccessEvent event, emit) {
    emit(AuthLoadedSuccessState(event.verificationID));
  }

  void _authRequestErrorHandler(AuthErrorEvent event, emit) {
    emit(AuthFaliureState(event.error));
  }

  void _isShowButtonHandler(ShowButtonEvent event, emit) {
    emit(ShowButtonState(event.isShowButton));
  }

  @override
  Future<void> close() {
    _verificationSubscription.cancel();
    _errorSubscription.cancel();
    _showLoadingSubscription.cancel();
    _authRepository.close();

    return super.close();
  }
}
