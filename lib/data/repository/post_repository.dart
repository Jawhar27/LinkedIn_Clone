import 'package:linkedin_clone/data/data_provider/post_data_provider.dart';
import 'package:linkedin_clone/data/model/post_data.dart';

class PostRepository {
  final PostDataProvider postDataProvider;
  PostRepository({
    required this.postDataProvider,
  });

  Future<List<PostData>> fetchPosts() async {
    List<PostData> data = [];

    final response = await postDataProvider.fetchPosts();

    final postData = response['response']['data'] as List;

    data = postData.map((e) => PostData.fromJson(e)).toList();

    return data;
  }
}
