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
    notifyListeners(); // 1. Thông báo View hiển thị Loading
    try {
      // Giả lập độ trễ mạng 2 giây để quan sát rõ vòng xoay Loading trên UI
      await Future.delayed(const Duration(seconds: 2));
      _posts = await _api.fetchPosts();
      _status = ViewStatus.success; // 2. Thành công -> cập nhật dữ liệu
    } catch (e) {
      _error = e.toString();
      _status = ViewStatus.error; // 3. Báo lỗi
    } finally {
      notifyListeners(); // 4. Thông báo View vẽ lại theo State mới
    }
  }
}
