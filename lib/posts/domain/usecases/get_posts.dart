import 'package:bloc_learning/posts/domain/enitity/post.dart';
import 'package:bloc_learning/posts/domain/repository/post_repository.dart';

class GetPostsUseCase {
  final PostRepository postRepository;

  GetPostsUseCase(this.postRepository);

  Future<List<Post>> execute() async {
    return await postRepository.getPosts();
  }
}
