part of 'check_logged_user_bloc.dart';

abstract class CheckLoggedUserState {}

class UserInitialState extends CheckLoggedUserState {}

class UserLoggedState extends CheckLoggedUserState {}

class UserNotLoggedState extends CheckLoggedUserState {}
