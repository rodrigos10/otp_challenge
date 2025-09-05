// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class CadastroResponse {
  final String id;
  final String userName;
  final String email;
  final DateTime createdAt;
  final bool active;
  final String password;

  CadastroResponse({
    required this.id,
    required this.userName,
    required this.email,
    required this.createdAt,
    required this.active,
    required this.password,
  });

  CadastroResponse copyWith({
    String? id,
    String? userName,
    String? email,
    DateTime? createdAt,
    bool? active,
    String? password,
  }) {
    return CadastroResponse(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      active: active ?? this.active,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'email': email,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'active': active,
      'password': password,
    };
  }

  factory CadastroResponse.fromMap(Map<String, dynamic> map) {
    return CadastroResponse(
      id: map['id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      active: map['active'] as bool,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CadastroResponse.fromJson(String source) => CadastroResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CadastroResponse(id: $id, userName: $userName, email: $email, createdAt: $createdAt, active: $active, password: $password)';
  }

  @override
  bool operator ==(covariant CadastroResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userName == userName &&
      other.email == email &&
      other.createdAt == createdAt &&
      other.active == active &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      active.hashCode ^
      password.hashCode;
  }
}
