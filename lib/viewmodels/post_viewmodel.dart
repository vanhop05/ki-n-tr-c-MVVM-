import 'package:flutter/foundation.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

enum ViewStatus { initial, loading, success, error }

class PostViewModel extends ChangeNotifier {
  final ApiService _api;
  PostViewModel({ApiService? api}) : _api = api ?? ApiService();

  ViewStatus _status = ViewStatus.initial;
  List<Post> _posts = [];
  String _error = '';

  ViewStatus get status => _status;
  List<Post> get posts => _posts;
  String get error => _error;

  Future<void> fetchPosts() async {
    _status = ViewStatus.loading;
    notifyListeners(); // 1. Báo View hiển thị Loading
    try {
      _posts = await _api.fetchPosts();
      _status = ViewStatus.success; // 2. Thành công -> cập nhật dữ liệu
    } catch (e) {
      _error = 'Không thể kết nối Internet hoặc Lỗi kết nối mạng.\nVui lòng kiểm tra lại!';
      _status = ViewStatus.error; // 3. Báo lỗi
    } finally {
      notifyListeners(); // 4. Cập nhật UI
    }
  }
}
