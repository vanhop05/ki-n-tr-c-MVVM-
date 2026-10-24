import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  // Đường dẫn REST API danh sách sinh viên
  static const _url = 'students.json';

  Future<List<Post>> fetchPosts() async {
    final uri = Uri.base.scheme.startsWith('http')
        ? Uri.base.resolve(_url)
        : Uri.parse(_url);

    final res = await http.get(uri).timeout(const Duration(seconds: 10));

    if (res.statusCode == 200) {
      final List list = jsonDecode(res.body);
      return list.map((e) => Post.fromJson(e)).toList();
    }
    throw Exception('Lỗi HTTP: ${res.statusCode}');
  }
}
