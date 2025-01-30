import 'package:bloc_learning/posts/domain/enitity/post.dart';
import 'package:bloc_learning/posts/domain/usecases/get_posts_by_id.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final GetPostsByIdUseCase getPostByIdUseCase;

  PostDetailsBloc({required this.getPostByIdUseCase})
      : super(PostDetailsInitial()) {
    on<FetchPostById>(_onFetchPostById);
  }

  _onFetchPostById(FetchPostById event, Emitter<PostDetailsState> emit) async {
    emit(PostDetailsLoading());

    try {
      final post = await getPostByIdUseCase.execute(event.id);
      emit(PostDetailsLoaded(post));
    } catch (e) {
      emit(const PostDetailsError("sorry error"));
    }
  }
}
