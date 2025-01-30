import 'package:bloc_learning/posts/data/datasources/remote_data_sources.dart';
import 'package:bloc_learning/posts/data/repositories/post_repository_imp.dart';
import 'package:bloc_learning/posts/domain/usecases/get_posts_by_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_details_bloc/post_details_bloc.dart';

class PostSearchPage extends StatelessWidget {
  PostSearchPage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Page"),
        centerTitle: true,
      ),
      body: BlocProvider(
          create: (_) => PostDetailsBloc(
              getPostByIdUseCase: GetPostsByIdUseCase(
                  PostRepositoryImp(remoteDataSources: RemoteDataSources())))
            ..add(FetchPostById(int.parse(controller.text))),
          child: SearchView()),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
