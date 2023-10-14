part of 'posts_bloc.dart';

sealed class PostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostsFetched extends PostsEvent {}
