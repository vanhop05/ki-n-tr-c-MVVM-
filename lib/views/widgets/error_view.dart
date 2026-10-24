import 'package:flutter/material.dart';

/// Widget hiển thị thông báo lỗi và nút thử tải lại.
class ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  /// Nhận nội dung lỗi và callback khi người dùng bấm thử lại.
  const ErrorView({super.key, required this.error, required this.onRetry});

  /// Xây dựng giao diện thông báo lỗi.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 56, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }
}
