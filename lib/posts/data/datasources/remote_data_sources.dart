import 'package:bloc_learning/posts/data/models/post.dart';
import 'package:dio/dio.dart';

class RemoteDataSources {
  final dio = Dio();
  Future<List<PostModel>> getPosts() async {
    final response = await dio.get('https://jsonplaceholder.org/posts');
    return (response.data as List)
        .map((post) => PostModel.fromJson(post))
        .toList();
  }

  Future<PostModel> getPostById(int id) async {
    final response = await dio.get('https://jsonplaceholder.org/posts/$id');
    return PostModel.fromJson(response.data);
  }
}
