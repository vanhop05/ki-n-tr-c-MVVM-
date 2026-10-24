class Post {
  final int id;
  final String studentId; // Số thẻ sinh viên
  final String name;      // Họ và tên
  final String className; // Lớp sinh hoạt

  Post({
    required this.id,
    required this.studentId,
    required this.name,
    required this.className,
  });

  // Tương thích với Slide 7
  String get title => name;
  String get body => 'MSSV: $studentId | Lớp: $className';

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int? ?? 0,
      studentId: (json['studentId'] ?? json['mssv'] ?? '').toString(),
      name: (json['name'] ?? json['title'] ?? '').toString(),
      className: (json['className'] ?? json['lop'] ?? '').toString(),
    );
  }
}
