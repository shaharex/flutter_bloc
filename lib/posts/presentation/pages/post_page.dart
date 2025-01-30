import 'package:bloc_learning/posts/data/datasources/remote_data_sources.dart';
import 'package:bloc_learning/posts/data/repositories/post_repository_imp.dart';
import 'package:bloc_learning/posts/domain/usecases/get_posts.dart';
import 'package:bloc_learning/posts/presentation/bloc/post_list_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Post List"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => PostBloc(
            getPostsUseCase: GetPostsUseCase(
                PostRepositoryImp(remoteDataSources: RemoteDataSources())))
          ..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? const BottomLoader()
                    : PostListItem(post: state.posts[index]);
              },
              itemCount: state.posts.length,
            );
          case PostStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
