part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpFormLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class GoogleSignUpSuccess extends SignUpState {
  final User? firebaseUser;
  const GoogleSignUpSuccess({
    this.firebaseUser,
  });
}

class SignUpFailure extends SignUpState {
  final String errorMessage;
  const SignUpFailure({
    required this.errorMessage,
  });
}
