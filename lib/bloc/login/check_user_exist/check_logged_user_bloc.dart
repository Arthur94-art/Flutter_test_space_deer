import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/data/repository/check_user_repository.dart';

part 'check_logged_user_event.dart';
part 'check_logged_user_state.dart';

class CheckLoggedUserBloc
    extends Bloc<CheckLoggedUserEvent, CheckLoggedUserState> {
  final CheckUserRepository _checkUserRepository = CheckUserRepository();
  CheckLoggedUserBloc() : super(UserInitialState()) {
    on<IsUserLoggedEvent>(_isUserLoggedEventHandler);
  }
  Future<void> _isUserLoggedEventHandler(IsUserLoggedEvent event, emit) async {
    emit(UserInitialState());
    bool isUserLogged = await _checkUserRepository.isUserLogged();
    if (isUserLogged) {
      emit(UserLoggedState());
    } else {
      emit(UserNotLoggedState());
    }
  }
}
