import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  const Post({
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

  @override
  List<Object?> get props => [id, title, content];
}
