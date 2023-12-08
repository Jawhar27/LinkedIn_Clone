import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkedin_clone/data/data_provider/post_data_provider.dart';
import 'package:linkedin_clone/data/data_provider/user_info_data_provider.dart';
import 'package:linkedin_clone/data/model/post_data.dart';
import 'package:linkedin_clone/data/model/user_info.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';

class UserInfoRepository {
  final UserInfoDataProvider userInfoDataProvider;
  UserInfoRepository({
    required this.userInfoDataProvider,
  });

  Future<UserInfoData> fetchUserData() async {
    UserInfoData userInfo;

    final response = await userInfoDataProvider.fetchUserData();

    final userData = response['response']['data'];

    userInfo = UserInfoData.fromJson(userData);

    return userInfo;
  }
}
