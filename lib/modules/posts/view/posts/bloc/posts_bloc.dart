import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_list_app/modules/posts/repositories/post_repository.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../models/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final IPostRepository postRepository;

  PostsBloc({required this.postRepository}) : super(const PostsState()) {
    on<PostsFetched>(_onPostsFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPostsFetched(
      PostsFetched event, Emitter<PostsState> emit) async {
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: posts.isEmpty ? true : false,
        ));
      }
      final posts = await _fetchPosts(state.posts.length);
      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false,
            ));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    try {
      return postRepository.fetchPosts(start: startIndex, limit: _postLimit);
    } catch (e) {
      throw Exception('error fetching posts');
    }
  }
}
