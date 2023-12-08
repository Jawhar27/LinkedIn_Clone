import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';

class PostDataProvider {
  Future<Map<String, dynamic>> fetchPosts() async {
    printLogs('DATA provider called!');
    Map<String, dynamic> postData = {
      "response": {
        "code": 200,
        "message": "Posts retrived Successfully!",
        "data": [
          {
            'id': 1,
            'profileImg': sliderImage3,
            'username': "John Doe",
            'userDescription':
                "Full-Stack Flutter Developer, Firebase Expert | Youtuber | Blogger",
            'createdAt': "1w",
            'postDescription':
                "Some common mistakes that flutter developer make while learning flutter.",
            'postImage': sliderImage3,
            'postImages': [sliderImage1, sliderImage2, sliderImage3],
            'tags': [
              "#code",
              "#flutterdevelopment",
              "#flutterui",
              "#fluttermafia",
              "#fullstackdeveloper",
              "#fluttercode",
              "#iosdeveloper"
            ],
            'totalReactions': 5,
            'totalComments': 10,
            'totalReposts': 4,
          },
          {
            'id': 2,
            'profileImg': sliderImage1,
            'username': "Alexander Graham Bell",
            'userDescription': "Inventor | Developer | Mobile Founder",
            'createdAt': "1d",
            'postDescription':
                "What's up people ?\nLook at this Alexander got something new to show you.",
            'postImage': sliderImage2,
            'postImages': [],
            'tags': [
              "#gde",
              "#googledevexpert",
              "#iosdevelopment",
              "#android",
              "#androidsummit",
              "#googlestudentsclub",
              "#growwithgoogle"
            ],
            'totalReactions': 4,
            'totalComments': 8,
            'totalReposts': 17,
          },
        ]
      }
    };

    // SAMPLE DURATION FOR SERVER RESPONSE
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    return postData;
  }
}
