import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  // REST API online chứa danh sách 28 sinh viên
  static const _url = 'https://extendsclass.com/api/json-storage/bin/dfccbbe';

  Future<List<Post>> fetchPosts() async {
    // Thêm tham số timestamp để tránh trình duyệt lưu Cache (do server gửi max-age=7200)
    // Không thêm custom headers để giữ nguyên chuẩn Simple Request, không bị lỗi CORS
    final uri = Uri.parse('$_url?t=${DateTime.now().millisecondsSinceEpoch}');

    final res = await http.get(uri).timeout(const Duration(seconds: 5));

    if (res.statusCode == 200) {
      final List list = jsonDecode(res.body);
      return list.map((e) => Post.fromJson(e)).toList();
    }
    throw Exception('Lỗi HTTP: ${res.statusCode}');
  }
}
