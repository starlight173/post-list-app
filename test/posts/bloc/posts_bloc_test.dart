import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:post_list_app/modules/posts/models/post.dart';
import 'package:post_list_app/modules/posts/repositories/post_repository.dart';
import 'package:post_list_app/modules/posts/view/posts/bloc/posts_bloc.dart';

import 'posts_bloc_test.mocks.dart';

@GenerateMocks([IPostRepository])
void main() {
  group('PostsBloc', () {
    late MockIPostRepository postRepository;
    late PostsBloc postsBloc;
    final mockPosts = List.generate(
      20,
      (i) => Post(
        id: i,
        userId: i,
        title: 'Post $i',
        body: 'This is the first post.',
      ),
    );

    setUp(() {
      postRepository = MockIPostRepository();
      postsBloc = PostsBloc(postRepository: postRepository);
    });

    blocTest(
      'Emits [success] state when posts are fetched successfully',
      build: () {
        when(postRepository.fetchPosts(start: 0, limit: 20))
            .thenAnswer((_) async => mockPosts);
        return postsBloc;
      },
      act: (bloc) => bloc.add(PostsFetched()),
      expect: () => [
        PostsState(
          status: PostStatus.success,
          posts: mockPosts,
          hasReachedMax: false,
        ),
      ],
    );

    blocTest(
      'Emit `hasReachedMax` true when no more posts',
      build: () {
        when(postRepository.fetchPosts(start: 0, limit: 20))
            .thenAnswer((_) async => []);
        return postsBloc;
      },
      act: (bloc) => bloc.add(PostsFetched()),
      expect: () => [
        const PostsState(
          status: PostStatus.success,
          posts: [],
          hasReachedMax: true,
        ),
      ],
    );

    blocTest(
      'Emits [failure] when posts are fetched unsuccessfully',
      build: () {
        when(postRepository.fetchPosts()).thenThrow(Exception());
        return postsBloc;
      },
      act: (bloc) => bloc.add(PostsFetched()),
      expect: () => [
        const PostsState(status: PostStatus.failure),
      ],
    );
  });
}
