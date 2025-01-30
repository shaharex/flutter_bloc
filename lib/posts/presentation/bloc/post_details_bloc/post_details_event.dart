part of 'post_details_bloc.dart';

sealed class PostDetailsEvent extends Equatable {
  const PostDetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchPostById extends PostDetailsEvent {
  final int id;

  const FetchPostById(this.id);

  @override
  List<Object> get props => [id];
}
