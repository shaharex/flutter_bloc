import 'package:bloc_learning/posts/domain/enitity/post.dart';
import 'package:bloc_learning/posts/domain/repository/post_repository.dart';

class GetPostsByIdUseCase {
  final PostRepository postRepository;

  GetPostsByIdUseCase(this.postRepository);

  Future<Post> execute(int id) async {
    return await postRepository.getPostById(id);
  }
}
