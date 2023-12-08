part of 'user_info_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final UserInfoData data;
  const UserInfoLoaded({
    required this.data,
  });
}

class NoUserInfoFound extends UserInfoState {}

class UserInfoLoadingerror extends UserInfoState {
  final String errorMessage;
  const UserInfoLoadingerror({
    required this.errorMessage,
  });
}
