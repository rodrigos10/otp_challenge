// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponse {
  final String userId;
  final String userName;

  LoginResponse({
    required this.userId,
    required this.userName,
  });


  LoginResponse copyWith({
    String? userId,
    String? userName,
  }) {
    return LoginResponse(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginResponse(userId: $userId, userName: $userName)';

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.userName == userName;
  }

  @override
  int get hashCode => userId.hashCode ^ userName.hashCode;
}
