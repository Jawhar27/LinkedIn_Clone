part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoginWithCredentialsPressed extends SignInEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({
    required this.email,
    required this.password,
  }) : super([email, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}

class SignInWithGooglePressed extends SignInEvent {
  @override
  String toString() => 'SignInWithGooglePressed';
}
