import 'package:bloc_learning/posts/domain/enitity/post.dart';

final class PostModel {
  const PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.thumbnail,
  });

  final int id;
  final String title;
  final String content;
  final String image;
  final String thumbnail;

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['image'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }

  Post toEntity() => Post(
        id: id,
        title: title,
        content: content,
        image: image,
        thumbnail: thumbnail,
      );
}
