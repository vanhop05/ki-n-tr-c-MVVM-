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
      appBar: AppBar(title: const Text('Demo Flutter MVVM')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          switch (viewModel.status) {
            case ViewStatus.loading:
              return const Center(child: CircularProgressIndicator());
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
