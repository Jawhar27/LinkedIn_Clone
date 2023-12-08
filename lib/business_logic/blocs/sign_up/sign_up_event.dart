part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class SignUpWithCredentials extends SignUpEvent {
  final String email;
  final String password;

  SignUpWithCredentials({
    required this.email,
    required this.password,
  }) : super([email, password]);

  @override
  String toString() {
    return 'SignupWithCredentialsPressed { email: $email, password: $password }';
  }
}

class SignUpWithGooglePressed extends SignUpEvent {
  @override
  String toString() => 'SignUpWithGooglePressed';
}
