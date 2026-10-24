import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            '${post.id}',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        title: Text(
          post.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          'Số thẻ SV: ${post.studentId}  •  Lớp: ${post.className}',
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: const Icon(Icons.badge_outlined, color: Colors.blueGrey),
      ),
    );
  }
}
