import 'package:flutter/material.dart';
import '../../models/post_model.dart';

/// Widget hiển thị thông tin tóm tắt của một bài viết.
class PostItem extends StatelessWidget {
  final Post post;
  /// Tạo item từ dữ liệu [post].
  const PostItem({super.key, required this.post});

  /// Xây dựng card gồm ID, tiêu đề và nội dung bài viết.
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text('${post.id}')),
        title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
