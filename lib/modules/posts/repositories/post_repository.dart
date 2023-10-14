import '../../../infra/network/api_provider.dart';
import '../models/post.dart';

abstract class IPostRepository {
  Future<List<Post>> fetchPosts({int start = 0, int limit = 10});
}

class PostRepository implements IPostRepository {
  final APIProvider apiProvider;

  PostRepository(this.apiProvider);

  @override
  Future<List<Post>> fetchPosts({int start = 0, int limit = 10}) async {
    final postsURL =
        "https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit";
    final todosDTO = await apiProvider.get(postsURL);
    final todos = List<Post>.from(todosDTO.map((x) => Post.fromJson(x)));
    return todos;
  }
}
