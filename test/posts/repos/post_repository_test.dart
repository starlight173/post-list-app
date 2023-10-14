import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:post_list_app/infra/network/api_provider.dart';
import 'package:post_list_app/modules/posts/models/post.dart';
import 'package:post_list_app/modules/posts/repositories/post_repository.dart';
import 'post_repository_test.mocks.dart';

// class MockApiProvider extends Mock implements APIProvider {}

@GenerateMocks([
  APIProvider,
])
void main() {
  group('PostRepository', () {
    late MockAPIProvider apiProvider;
    late PostRepository postRepository;

    setUp(() {
      apiProvider = MockAPIProvider();
      postRepository = PostRepository(apiProvider);
    });

    test('Fetches posts successfully', () async {
      // Arrange
      when(apiProvider.get(
              'https://jsonplaceholder.typicode.com/posts?_start=0&_limit=10'))
          .thenAnswer(
        (_) => Future.value([
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"},
          {"userId": 1, "id": 1, "title": "Title", "body": "Body"}
        ]),
      );

      // Act
      final posts = await postRepository.fetchPosts();
      expect(posts, isA<List<Post>>());
      expect(posts.length, 10);

      // Assert
      verify(apiProvider.get(
              'https://jsonplaceholder.typicode.com/posts?_start=0&_limit=10'))
          .called(1);
    });

    test('Throws an exception when fetching posts fails', () async {
      // Arrange
      when(apiProvider.get(
              'https://jsonplaceholder.typicode.com/posts?_start=0&_limit=10'))
          .thenThrow(Exception());

      // Act
      expect(() async => postRepository.fetchPosts(), throwsException);

      // Assert
      verify(apiProvider.get(
              'https://jsonplaceholder.typicode.com/posts?_start=0&_limit=10'))
          .called(1);
    });
  });
}
