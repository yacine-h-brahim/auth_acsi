import 'dart:convert';

class User {
  int? id = 0;
  String? username = '';
  String? email = '';
  String? password = '';
  String? name = '';
  String? lastname = '';
  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.name,
    this.lastname,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id ?? 0,
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'lastname': lastname,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      lastname: map['lastname'] != null ? map['lastname'] as String : null,
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
