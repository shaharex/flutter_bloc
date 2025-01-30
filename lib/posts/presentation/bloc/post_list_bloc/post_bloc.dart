import 'package:bloc_learning/posts/domain/usecases/get_posts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enitity/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;
  PostBloc({required this.getPostsUseCase}) : super(PostState()) {
    on<PostFetched>(_onFetched);
    on<PostRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onFetched(PostFetched event, Emitter<PostState> emit) async {
    if (state.status == PostStatus.success) return;

    if (state.status == PostStatus.initial) {
      try {
        final posts = await getPostsUseCase.execute();
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
        ));
      } catch (e) {
        print(e);
        emit(state.copyWith(status: PostStatus.failure));
      }
    }
  }

  Future<void> _onRefreshRequested(
      PostRefreshRequested event, Emitter<PostState> emit) async {
    emit(const PostState());
    await _onFetched(PostFetched(), emit);
  }
}
