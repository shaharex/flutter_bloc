part of 'post_details_bloc.dart';

sealed class PostDetailsState extends Equatable {
  const PostDetailsState();

  @override
  List<Object?> get props => [];
}

final class PostDetailsInitial extends PostDetailsState {}

final class PostDetailsLoading extends PostDetailsState {}

final class PostDetailsLoaded extends PostDetailsState {
  const PostDetailsLoaded(this.post);
  final Post post;

  @override
  List<Object?> get props => [post];
}

final class PostDetailsError extends PostDetailsState {
  const PostDetailsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
