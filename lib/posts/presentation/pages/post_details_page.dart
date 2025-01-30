import 'package:bloc_learning/posts/data/datasources/remote_data_sources.dart';
import 'package:bloc_learning/posts/data/repositories/post_repository_imp.dart';
import 'package:bloc_learning/posts/domain/usecases/get_posts_by_id.dart';
import 'package:bloc_learning/posts/presentation/bloc/post_details_bloc/post_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => PostDetailsBloc(
            getPostByIdUseCase: GetPostsByIdUseCase(
                PostRepositoryImp(remoteDataSources: RemoteDataSources())))
          ..add(FetchPostById(id)),
        child: const PostView(),
      ),
    );
  }
}

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsBloc, PostDetailsState>(
      builder: (context, state) {
        if (state is PostDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostDetailsError) {
          return Center(child: Text(state.message));
        } else if (state is PostDetailsLoaded) {
          final post = state.post;
          return ListView(
            children: [
              Container(
                height: 200,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Image.network(
                  post.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 50, 92),
                      ),
                    ),
                    Text(
                      'Id: ${post.id.toString()}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(post.content),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          );
        }
        return const Text("Ok");
      },
    );
  }
}
