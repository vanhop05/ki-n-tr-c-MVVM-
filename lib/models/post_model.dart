/// Model đại diện cho một bài viết nhận được từ API.
class Post {
  final int id;
  final String studentId; // Số thẻ sinh viên
  final String name;      // Họ và tên
  final String className; // Lớp sinh hoạt

<<<<<<< HEAD
  Post({
    required this.id,
    required this.studentId,
    required this.name,
    required this.className,
  });

  // Tương thích với Slide 7
  String get title => name;
  String get body => 'MSSV: $studentId | Lớp: $className';
=======
  /// Khởi tạo bài viết với ID, tiêu đề và nội dung.
  Post({required this.id, required this.title, required this.body});
>>>>>>> 9566120a201388dab91dfcc09eec66821ed0882a

  /// Chuyển dữ liệu JSON thành một đối tượng [Post].
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int? ?? 0,
      studentId: (json['studentId'] ?? json['mssv'] ?? '').toString(),
      name: (json['name'] ?? json['title'] ?? '').toString(),
      className: (json['className'] ?? json['lop'] ?? '').toString(),
    );
  }
}
