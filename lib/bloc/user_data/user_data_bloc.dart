import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/data/models/user_model.dart';
import 'package:test_space_deer/data/repository/user_repository.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final UserRepository _userRepository = UserRepository();
  UserDataBloc() : super(FetchUserInitialState()) {
    on<FetchUserEvent>(_fetchRequestHandler);
  }
  Future<void> _fetchRequestHandler(event, emit) async {
    try {
      final List<UserModel> userData = await _userRepository.getData();
      emit(FetchUserLoadedState(userData));
    } catch (e) {
      emit(FetchUserFailureState(e.toString()));
    }
  }
}
