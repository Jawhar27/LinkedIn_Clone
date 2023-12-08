import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkedin_clone/data/repository/authentication_repository.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository _authenticationRepository;
  SignInBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(SignInInitial()) {
    on<LoginWithCredentialsPressed>(_loginWithCredentials);
    on<SignInWithGooglePressed>(_signInWithGoogle);
  }

  void _loginWithCredentials(
      LoginWithCredentialsPressed event, Emitter<SignInState> emit) async {
    emit(SignInFormLoading());
    printLogs('LOGIN FUNCTION CALLED!');
    try {
      UserCredential? userCredential =
          await _authenticationRepository.signInWithCredentials(
        event.email,
        event.password,
      );

      User? user = userCredential?.user;
      emit(SignInSuccess(
        firebaseUser: user,
      ));
    } on FirebaseAuthException catch (error) {
      printLogs(
        error.toString(),
      );
      String errorMessage = 'error';
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;

        default:
          errorMessage = "An undefined Error happened. Please try again!";
          emit(
            SignInFailure(
              errorMessage: errorMessage,
            ),
          );
      }
    } catch (e) {
      printLogs(e.toString());
      emit(
        SignInFailure(
          errorMessage: "An undefined Error happened. Please try again!",
        ),
      );
    }
  }

  void _signInWithGoogle(
      SignInWithGooglePressed event, Emitter<SignInState> emit) async {
    emit(SignInFormLoading());
    printLogs('SIGN IN GOOGLE FUNCTION CALLED!');
    try {
      UserCredential? userCredential =
          await _authenticationRepository.signInWithGoogle();
      User? user = userCredential?.user;
      printLogs('*****USER DETAILS*******${user!.email ?? ''}');
      emit(
        SignInSuccess(
          firebaseUser: user,
        ),
      );
    } catch (_) {
      emit(
        SignInFailure(
          errorMessage: 'Google Sign in failed!',
        ),
      );
    }
  }
}
