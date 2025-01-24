class Post {
  final int id;
  final String title;
  final String content; // <-- ici la propriété s'appelle content

  Post({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String, // <-- vous cherchez la clé "content"
    );
  }
}
