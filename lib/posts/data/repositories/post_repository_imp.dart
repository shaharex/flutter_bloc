import 'package:bloc_learning/posts/data/datasources/remote_data_sources.dart';
import 'package:bloc_learning/posts/domain/enitity/post.dart';
import 'package:bloc_learning/posts/domain/repository/post_repository.dart';

class PostRepositoryImp implements PostRepository {
  final RemoteDataSources remoteDataSources;
  PostRepositoryImp({required this.remoteDataSources});

  @override
  Future<List<Post>> getPosts() async {
    final postModels = await remoteDataSources.getPosts();
    print(postModels);
    return postModels.map((postModel) => postModel.toEntity()).toList();
  }

  @override
  Future<Post> getPostById(int id) async {
    final postModel = await remoteDataSources.getPostById(id);
    return postModel.toEntity();
  }
}
