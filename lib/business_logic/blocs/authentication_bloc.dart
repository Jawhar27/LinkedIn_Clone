import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:linkedin_clone/data/repository/authentication_repository.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(Uninitialized()) {
    on<AppStarted>(_appStarted);
    on<LoggedIn>(_loggedIn);
    on<LoggedOut>(_loggedOut);
  }

  void _appStarted(AppStarted event, Emitter<AuthenticationState> emit) async {
    try {
      final isSignedIn = await _authenticationRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _authenticationRepository.getUser();
        emit(Authenticated(name ?? ''));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  void _loggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(Authenticated(await _authenticationRepository.getUser() ?? ''));
  }

  void _loggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    printLogs('LOGGED OUT CALLED!');
    emit(Unauthenticated());
    _authenticationRepository.signOut();
  }
}
