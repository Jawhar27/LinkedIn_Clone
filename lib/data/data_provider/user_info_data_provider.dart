import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';

class UserInfoDataProvider {
  Future<Map<String, dynamic>> fetchUserData() async {
    printLogs('UserInfo DATA provider called!');
    Map<String, dynamic> userInfoData = {
      "response": {
        "code": 200,
        "message": "Posts retrived Successfully!",
        "data": {
          'id': 1,
          'name': "Jawhar Sivagnanam",
          'work_position': "Associate Software Engineer @ABC Company",
          'work_place': "Sabaragamuwa University",
          'country': "Sri Lanka",
          'no_of_connections': 390,
          'no_of_followers': 209,
          'no_of_post_impressions': 2068,
          'no_of_profile_views': 16,
          'no_of_search_appearances': 18,
          'creator_mode': true,
          'work_experience': [
            {
              'item_title': 'Associate Software Engineer',
              'sub_text1': 'ABC Company - Full-time',
              'sub_text2':
                  'July 2022 - Nov 2023  -  1 yr 5 mos\nColombo, Western province, Sri Lanka.'
            },
            {
              'item_title': 'Trainee Software Engineer',
              'sub_text1': 'XYX Company - Full-time',
              'sub_text2':
                  'Feb 2021 - July 2021  -  6 mos\nColombo, Western province, Sri Lanka.'
            }
          ],
          'education': [
            {
              'item_title': 'Sabararagamuwa University of Sri Lanka',
              'sub_text1': 'Bsc in Computing and Information Systems',
              'sub_text2': 'Dec 2017 - Feb 2023.'
            },
            {
              'item_title': 'Winsys City Campus, Bambalapitiya',
              'sub_text1': 'Advanced Diploma in Networking and Security',
              'sub_text2': 'July 2022 - Nov 2022'
            }
          ],
          'skills': [
            {
              'item_title': 'Laravel',
              'sub_text1': '  2 endorsements',
            },
            {
              'item_title': 'Problem Solving',
              'sub_text1': '  10 endorsements',
            }
          ],
          'courses': [
            {
              'item_title': 'Flutter and dart the complete guide',
              'sub_text1': 'Udemy - Maximillian',
            },
            {
              'item_title':
                  'PHP with laravel for beginners - become a master in laravel',
              'sub_text1': 'Udemy - Edwin Dias',
            }
          ],
          'interest_companies': [
            {
              'item_title': 'Google',
              'sub_text1': '15,606,800 followers',
            },
            {
              'item_title': 'Microsoft',
              'sub_text1': '13,508,500 followers',
            },
          ],
          'viewed_people': [
            {
              'item_title': 'Virat Kohli',
              'sub_text1': 'Student at Sabaragamuwa University',
            },
            {
              'item_title': 'Hardik pandya',
              'sub_text1': 'Student at Sabaragamuwa University',
            },
          ]
        },
      }
    };
    // SAMPLE DURATION FOR SERVER RESPONSE
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    return userInfoData;
  }
}
