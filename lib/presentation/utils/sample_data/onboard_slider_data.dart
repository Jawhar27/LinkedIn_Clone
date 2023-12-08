import 'package:linkedin_clone/assets.dart';

class OnboardData {
  final String? image;
  final String? title;

  OnboardData({
    this.image,
    this.title,
  });

  static List<OnboardData> onBoardingDataList = [
    OnboardData(
      image: sliderImage1,
      title: "Find and land your next job",
    ),
    OnboardData(
      image: sliderImage2,
      title: "Build your nextwork on the go",
    ),
    OnboardData(
      image: sliderImage3,
      title: "Stay ahead with curated content for\nyour career",
    ),
  ];
}
