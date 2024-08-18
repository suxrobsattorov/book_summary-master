import 'dart:convert';

import 'book.dart';

class User {
  final String id;
  final String fullname;
  final String email;

  User({
    required this.id,
    required this.fullname,
    required this.email,
  });

  User copyWith({
    String? id,
    String? fullname,
    String? email,
    List<Book>? favoriteBooks,
    List<Book>? history,
  }) {
    return User(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // result.addAll({'id': id});
    result.addAll({'fullname': fullname});
    result.addAll({'email': email});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, fullname: $fullname, email: $email)';
  }
}
