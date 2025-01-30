import 'package:bloc_learning/posts/data/datasources/remote_data_sources.dart';
import 'package:bloc_learning/posts/data/repositories/post_repository_imp.dart';
import 'package:bloc_learning/posts/domain/usecases/get_posts_by_id.dart';
import 'package:bloc_learning/posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_details_bloc/post_details_bloc.dart';

class PostSearchPage extends StatelessWidget {
  const PostSearchPage({super.key});

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
                PostRepositoryImp(remoteDataSources: RemoteDataSources()))),
        child: SearchView(),
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  SearchView({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 242, 242),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: IconButton(
                  onPressed: () {
                    if (int.tryParse(controller.text) is int) {
                      context
                          .read<PostDetailsBloc>()
                          .add(FetchPostById(int.parse(controller.text)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Numbers only"),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.search)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<PostDetailsBloc, PostDetailsState>(
            builder: (context, state) {
          if (state is PostDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is PostDetailsLoaded) {
            return PostListItem(post: state.post);
          } else if (state is PostDetailsError) {
            return Text(state.message);
          } else if (state is PostDetailsInitial) {
            return const Center(
              child: Text("Start Searching"),
            );
          }
          return const Center(
            child: Text("jk"),
          );
        })
      ],
    );
  }
}
