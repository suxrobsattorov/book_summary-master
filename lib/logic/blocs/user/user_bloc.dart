import 'package:bloc/bloc.dart';
import 'package:book_summary/data/models/user.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  UserBloc(
      {required UserRepository userRepository,
      required AuthRepository authRepository})
      : _userRepository = userRepository,
        _authRepository = authRepository,
        super(UserInitial()) {
    on<GetUserEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          final userId = _authRepository.currentUser!.uid;
          await emit.forEach(
            _userRepository.getUser(userId),
            onData: (User? user) {
              if (user != null) {
                return LoadedState(user);
              }
              return ErrorState('null');
            },
          );
        } catch (e) {
          emit(ErrorState(e.toString()));
        }
      },
    );
    on<UserEditEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final userId = _authRepository.currentUser!.uid;
        final email = _authRepository.currentUser!.email;
        final user = User(
            id: userId,
            name: event.name,
            surname: event.surname,
            email: email!);
        await _userRepository.editUser(userId, user);
        emit(LoadedState(user));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
