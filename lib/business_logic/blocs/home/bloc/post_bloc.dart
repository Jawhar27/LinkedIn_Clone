import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:linkedin_clone/data/model/post_data.dart';
import 'package:linkedin_clone/data/repository/post_repository.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc({
    required PostRepository postRepository,
  })  : _postRepository = postRepository,
        super(PostInitial()) {
    on<FetchPostsEvent>(_fetchAllPosts);
  }

  void _fetchAllPosts(FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(
      PostLoading(),
    );
    printLogs('FETCH POSTS FUNCTION CALLED!');
    try {
      final posts = await _postRepository.fetchPosts();
      if (posts.isNotEmpty) {
        emit(
          PostLoaded(
            posts: posts,
          ),
        );
      } else {
        emit(
          NoPostsFound(),
        );
      }
    } catch (_) {
      emit(
        const PostLoadingerror(
          errorMessage: 'Post Fetching Failed, Please try again later!',
        ),
      );
    }
  }
}
