/// Model đại diện cho một bài viết nhận được từ API.
class Post {
  final int id;
  final String title, body;

  /// Khởi tạo bài viết với ID, tiêu đề và nội dung.
  Post({required this.id, required this.title, required this.body});

  /// Chuyển dữ liệu JSON thành một đối tượng [Post].
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
