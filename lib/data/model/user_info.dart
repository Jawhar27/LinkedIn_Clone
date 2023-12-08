import 'package:linkedin_clone/data/model/category_item.dart';

class UserInfoData {
  final String? name;
  final String? workPosition;
  final String? workPlace;
  final String? country;
  final int? noOfConnections;
  final int? noOfProfileViews;
  final int? noOfPostImpressions;
  final int? noOfSearchAppearances;
  final int? noOfFollowers;
  final bool? creatorMode;
  final List<CategoryItem>? workExperience;
  final List<CategoryItem>? education;
  final List<CategoryItem>? skills;
  final List<CategoryItem>? courses;
  final List<CategoryItem>? interestCompanies;
  final List<CategoryItem>? viewedPeopleList;

  UserInfoData({
    this.name,
    this.workPosition,
    this.workPlace,
    this.country,
    this.noOfConnections,
    this.workExperience,
    this.education,
    this.skills,
    this.courses,
    this.interestCompanies,
    this.viewedPeopleList,
    this.creatorMode,
    this.noOfFollowers,
    this.noOfPostImpressions,
    this.noOfProfileViews,
    this.noOfSearchAppearances,
  });

  factory UserInfoData.fromJson(Map<dynamic, dynamic> json) => UserInfoData(
        name: json['name'],
        workPosition: json['work_position'],
        workPlace: json['work_place'],
        country: json['country'],
        noOfConnections: json['no_of_connections'],
        creatorMode: json['creator_mode'],
        noOfFollowers: json['no_of_followers'],
        noOfPostImpressions: json['no_of_post_impressions'],
        noOfProfileViews: json['no_of_profile_views'],
        noOfSearchAppearances: json['no_of_search_appearances'],
        workExperience: (json['work_experience'] as List)
            .map((e) => CategoryItem.fromJson(e))
            .toList(),
        education: (json['education'] as List)
            .map((e) => CategoryItem.fromJson(e))
            .toList(),
        skills: (json['skills'] as List)
            .map((e) => CategoryItem.fromJson(e))
            .toList(),
        courses: (json['courses'] as List)
            .map((e) => CategoryItem.fromJson(e))
            .toList(),
        interestCompanies: (json['interest_companies'] as List)
            .map((e) => CategoryItem.fromJson(e))
            .toList(),
        viewedPeopleList: (json['viewed_people'] as List)
            .map((e) => CategoryItem.fromJson(e))
            .toList(),
      );
}
