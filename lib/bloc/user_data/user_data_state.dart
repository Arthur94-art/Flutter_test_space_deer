part of 'user_data_bloc.dart';

abstract class UserDataState {}

class FetchUserInitialState extends UserDataState {}

class FetchUserLoadedState extends UserDataState {
  final List<UserModel> userModel;
  FetchUserLoadedState(this.userModel);
}

class FetchUserFailureState extends UserDataState {
  final String errorMessage;
  FetchUserFailureState(this.errorMessage);
}
