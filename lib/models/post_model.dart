class Post {
  final int id;
  final String name;

  Post({required this.id, required this.name});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int? ?? 0,
      name: (json['name'] ?? '').toString(),
    );
  }
}
