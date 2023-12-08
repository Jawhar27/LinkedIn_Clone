part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInFormLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final User? firebaseUser;
  SignInSuccess({
    this.firebaseUser,
  });
}

class SignInFailure extends SignInState {
  final String errorMessage;
  SignInFailure({
    required this.errorMessage,
  });
}
