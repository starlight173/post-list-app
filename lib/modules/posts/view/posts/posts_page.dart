import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../infra/network/api_provider.dart';
import '../../repositories/post_repository.dart';
import 'bloc/posts_bloc.dart';
import 'post_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) => PostsBloc(
            postRepository: PostRepository(APIProvider(http.Client())))
          ..add(PostsFetched()),
        child: const PostsList(),
      ),
    );
  }
}
