import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  // REST API online chứa danh sách 28 sinh viên trên Internet
  static const _url = 'https://extendsclass.com/api/json-storage/bin/dfccbbe';

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
