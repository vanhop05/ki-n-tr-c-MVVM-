import 'package:flutter/foundation.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

// Định nghĩa 3 trạng thái giao diện rõ ràng
enum ViewStatus { loading, success, error }

class PostViewModel extends ChangeNotifier {
  final PostService _postService;

  PostViewModel({PostService? postService})
      : _postService = postService ?? PostService();

  ViewStatus _status = ViewStatus.loading;
  List<PostModel> _posts = [];
  String _errorMessage = '';

  // Getters công khai để View đọc dữ liệu
  ViewStatus get status => _status;
  List<PostModel> get posts => _posts;
  String get errorMessage => _errorMessage;

  Future<void> loadPosts() async {
    _status = ViewStatus.loading;
    _errorMessage = '';
    notifyListeners(); // Báo View hiển thị ProgressBar

    try {
      _posts = await _postService.fetchPosts();
      _status = ViewStatus.success;
    } catch (e) {
      _status = ViewStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      notifyListeners(); // Báo View cập nhật giao diện Success hoặc Error
    }
  }
}