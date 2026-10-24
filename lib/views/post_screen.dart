import 'package:flutter/material.dart';
import '../viewmodels/post_viewmodel.dart';
import 'widgets/error_view.dart';
import 'widgets/post_item.dart';

class PostScreen extends StatelessWidget {
  final PostViewModel viewModel;
  const PostScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Sinh Viên - Lập Trình ĐNT'),
        centerTitle: true,
      ),
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
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 220,
                      height: 24,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: const LinearProgressIndicator(
                          color: Colors.green,
                          backgroundColor: Colors.white,
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
