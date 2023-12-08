class PostData {
  final int? id;
  final String? username;
  final String? profileImg;
  final String? userDescription;
  final String? createdAt;
  final String? postDescription;
  final String? postImage;
  final List<String>? tags;
  final List<String>? postImages;
  final num? totalReactions;
  final num? totalComments;
  final num? totalReposts;

  PostData({
    this.id,
    this.username,
    this.profileImg,
    this.userDescription,
    this.createdAt,
    this.postDescription,
    this.postImage,
    this.tags,
    this.postImages,
    this.totalReactions,
    this.totalComments,
    this.totalReposts,
  });

  factory PostData.fromJson(Map<dynamic, dynamic> json) => PostData(
        id: json['id'],
        username: json['username'],
        profileImg: json['profileImg'],
        userDescription: json['userDescription'],
        createdAt: json['createdAt'],
        postDescription: json['postDescription'],
        postImage: json['postImage'],
        tags: json['tags'],
        postImages: (json['postImages'] as List).cast<String>(),
        totalReactions: json['totalReactions'],
        totalComments: json['totalComments'],
        totalReposts: json['totalReposts'],
      );
}
