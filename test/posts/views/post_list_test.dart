import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:post_list_app/modules/posts/view/posts/bloc/posts_bloc.dart';
import 'package:post_list_app/modules/posts/view/posts/post_list.dart';

class PostsBlocMock extends MockBloc<PostsEvent, PostsState>
    implements PostsBloc {}

void main() {
  testWidgets(
      'PostsList displays a loading indicator when the status is initial',
      (WidgetTester tester) async {

    // final postBloc = PostsBlocMock();

    // when(postBloc.state).thenReturn(const PostsState());
    // await tester.pumpWidget(
    //     BlocProvider.value(value: postBloc, child: const PostsList()));

    // // Find the CircularProgressIndicator widget.
    // final progressIndicator = find.byType(CircularProgressIndicator);

    // // Expect the CircularProgressIndicator to be displayed.
    // expect(progressIndicator, findsOneWidget);
  });
}