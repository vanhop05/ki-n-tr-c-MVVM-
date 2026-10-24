import 'package:flutter/foundation.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

/// Các trạng thái của quá trình tải danh sách bài viết.
enum ViewStatus { initial, loading, success, error }

/// Quản lý dữ liệu và trạng thái giữa API service và giao diện.
class PostViewModel extends ChangeNotifier {
  final ApiService _api;

  /// Cho phép truyền API service tùy chỉnh, hữu ích khi kiểm thử.
  PostViewModel({ApiService? api}) : _api = api ?? ApiService();

  ViewStatus _status = ViewStatus.initial;
  List<Post> _posts = [];
  String _error = '';

  /// Trạng thái hiện tại của ViewModel.
  ViewStatus get status => _status;

  /// Danh sách bài viết đã tải được.
  List<Post> get posts => _posts;

  /// Nội dung lỗi để giao diện hiển thị.
  String get error => _error;

  /// Tải dữ liệu, cập nhật trạng thái và thông báo cho các listener.
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
