import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkedin_clone/data/repository/authentication_repository.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  SignUpBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(SignUpInitial()) {
    on<SignUpWithCredentials>(_signUpWithCredentials);
    on<SignUpWithGooglePressed>(_signUpWithGoogle);
  }

  void _signUpWithCredentials(
      SignUpWithCredentials event, Emitter<SignUpState> emit) async {
    emit(SignUpFormLoading());
    printLogs('SignUp FUNCTION CALLED!');
    printLogs('${event.email}-----------${event.password}');
    try {
      await _authenticationRepository.signUp(
        email: event.email,
        password: event.password,
      );
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (error) {
      String errorMessage = 'error';
      switch (error.code) {
        case "wrong-password":
          errorMessage = "Your password is invalid";
          break;
        case "invalid-email":
          errorMessage = "Your email is invalid";
          break;
        case "email-already-in-use":
          errorMessage = "Email is already in use on different account";
          break;

        default:
          errorMessage = "An undefined Error happened. Please try again!";
      }
      emit(SignUpFailure(
        errorMessage: errorMessage,
      ));
    } catch (e) {
      printLogs(e.toString());
      emit(
        const SignUpFailure(
          errorMessage: "An undefined Error happened. Please try again!",
        ),
      );
    }
  }

  void _signUpWithGoogle(
      SignUpWithGooglePressed event, Emitter<SignUpState> emit) async {
    emit(SignUpFormLoading());
    printLogs('SIGN UP GOOGLE FUNCTION CALLED!');
    try {
      UserCredential? userCredential =
          await _authenticationRepository.signInWithGoogle();
      User? user = userCredential?.user;
      emit(GoogleSignUpSuccess(
        firebaseUser: user,
      ));
    } catch (_) {
      emit(
        const SignUpFailure(
          errorMessage: 'Google Sign in failed!',
        ),
      );
    }
  }
}
