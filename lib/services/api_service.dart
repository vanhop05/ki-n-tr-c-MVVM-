import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  static const _url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final res = await http.get(Uri.parse(_url))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode == 200) {
      final List list = jsonDecode(res.body);
      return list.map((e) => Post.fromJson(e)).toList();
    }
    throw Exception('Lỗi HTTP: ${res.statusCode}');
  }
}
