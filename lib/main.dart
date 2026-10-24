import 'package:flutter/material.dart';
import 'viewmodels/post_viewmodel.dart';
import 'views/post_screen.dart';

void main() {
  final viewModel = PostViewModel()..fetchPosts();
  runApp(MyApp(viewModel: viewModel));
}

class MyApp extends StatelessWidget {
  final PostViewModel? viewModel;
  const MyApp({super.key, this.viewModel});

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
