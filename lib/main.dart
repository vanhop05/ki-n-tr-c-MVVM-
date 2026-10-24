import 'package:flutter/material.dart';
import 'viewmodels/post_viewmodel.dart';
import 'views/post_screen.dart';

/// Điểm khởi đầu của ứng dụng Flutter.
/// Tạo ViewModel, bắt đầu tải dữ liệu và chạy widget gốc.
void main() {
  final viewModel = PostViewModel()..fetchPosts();
  runApp(MyApp(viewModel: viewModel));
}

/// Widget gốc, chịu trách nhiệm cấu hình MaterialApp và màn hình chính.
class MyApp extends StatelessWidget {
  final PostViewModel? viewModel;
  /// [viewModel] có thể được truyền vào để thuận tiện cho việc kiểm thử.
  const MyApp({super.key, this.viewModel});

  /// Xây dựng theme và màn hình [PostScreen].
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Flutter MVVM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: PostScreen(viewModel: viewModel ?? (PostViewModel()..fetchPosts())),
    );
  }
}
