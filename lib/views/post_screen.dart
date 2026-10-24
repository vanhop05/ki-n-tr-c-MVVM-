import 'package:flutter/material.dart';
import '../viewmodels/post_viewmodel.dart';
import 'widgets/error_view.dart';
import 'widgets/post_item.dart';

/// Màn hình hiển thị danh sách bài viết theo trạng thái ViewModel.
class PostScreen extends StatelessWidget {
  final PostViewModel viewModel;
  /// Tạo màn hình với [viewModel] bắt buộc.
  const PostScreen({super.key, required this.viewModel});

  /// Hiển thị loading, lỗi hoặc danh sách dựa trên [viewModel.status].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Flutter MVVM')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          switch (viewModel.status) {
            case ViewStatus.loading:
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'LOADING....',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2, // Giãn khoảng cách các chữ cái
          ),
        ),
        const SizedBox(height: 12),
        // Khung viền hình viên thuốc
        Container(
          width: 220,
          height: 24,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black, width: 2), // Viền đen bên ngoài
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50), // Bo tròn phần ruột bên trong
            child: const LinearProgressIndicator(
              color: Colors.green,           // Dải màu xanh lá cây
              backgroundColor: Colors.white, // Nền trắng bên trong
            ),
          ),
        ),
      ],
    ),
  );
            case ViewStatus.error:
              return ErrorView(
                error: viewModel.error,
                onRetry: viewModel.fetchPosts,
              );
            case ViewStatus.success:
              return RefreshIndicator(
                onRefresh: viewModel.fetchPosts,
                child: ListView.builder(
                  itemCount: viewModel.posts.length,
                  itemBuilder: (_, i) => PostItem(post: viewModel.posts[i]),
                ),
              );
            default:  
              return const SizedBox();
          }
        },
      ),
    );
  }
}
