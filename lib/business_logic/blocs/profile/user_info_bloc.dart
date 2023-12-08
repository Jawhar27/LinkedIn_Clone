import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:linkedin_clone/data/model/user_info.dart';
import 'package:linkedin_clone/data/repository/user_info_repository.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInfoRepository _userInfoRepository;
  UserInfoBloc({
    required UserInfoRepository userInfoRepository,
  })  : _userInfoRepository = userInfoRepository,
        super(UserInfoInitial()) {
    on<FetchUserDataEvent>(_fetchUserData);
  }

  void _fetchUserData(
      FetchUserDataEvent event, Emitter<UserInfoState> emit) async {
    emit(
      UserInfoLoading(),
    );
    printLogs('FETCH USERDATA FUNCTION CALLED!');
    try {
      final userData = await _userInfoRepository.fetchUserData();
      if (userData != null) {
        emit(
          UserInfoLoaded(
            data: userData,
          ),
        );
      } else {
        emit(
          NoUserInfoFound(),
        );
      }
    } catch (_) {
      emit(
        const UserInfoLoadingerror(
          errorMessage: 'UserInfo Fetching Failed, Please try again later!',
        ),
      );
    }
  }
}
