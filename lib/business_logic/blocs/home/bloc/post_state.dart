part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostData> posts;
  const PostLoaded({
    required this.posts,
  });
}

class NoPostsFound extends PostState {}

class PostLoadingerror extends PostState {
  final String errorMessage;
  const PostLoadingerror({
    required this.errorMessage,
  });
}
