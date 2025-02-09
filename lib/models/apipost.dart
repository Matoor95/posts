
class Apipost {
  final int userId;
  final int id;
  final String title;
  final String body;

  Apipost({ required this.userId, required this.id, required  this.title, required this.body});

  factory Apipost.fromJson(Map<String, dynamic> json) {
    return Apipost(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}