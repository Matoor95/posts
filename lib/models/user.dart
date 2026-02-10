class User{
  int id;
  String email;
  String password;
  User({required this.id, required this.email, required this.password});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }


}