import 'dart:convert';

class User {
  String id;
  String role;
  String name;
  String cpf;
  String email;
  User({
    required this.id,
    required this.role,
    required this.name,
    required this.cpf,
    required this.email,
  });

  User copyWith({
    String? id,
    String? role,
    String? name,
    String? cpf,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      role: role ?? this.role,
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'role': role,
      'name': name,
      'cpf': cpf,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      role: map['role'] as String,
      name: map['name'] as String,
      cpf: map['cpf'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, role: $role, name: $name, cpf: $cpf, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.role == role &&
        other.name == name &&
        other.cpf == cpf &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        role.hashCode ^
        name.hashCode ^
        cpf.hashCode ^
        email.hashCode;
  }
}
