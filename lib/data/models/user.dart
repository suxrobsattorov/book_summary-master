import 'dart:convert';

class User {
  final String id;
  final String name;
  final String surname;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
  });

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
  }) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'surname': surname});
    result.addAll({'email': email});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map, String userId) {
    return User(
      id: userId,
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name,surname: $surname, email: $email)';
  }
}
