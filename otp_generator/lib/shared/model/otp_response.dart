// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OtpResponse {
  final String id;
  final String token;
  final String userId;
  final int duration;
  final DateTime expiresAt;
  final DateTime createdAt;
  final bool valid;

  OtpResponse({
    required this.id,
    required this.token,
    required this.userId,
    required this.duration,
    required this.expiresAt,
    required this.createdAt,
    required this.valid,
  });

  OtpResponse copyWith({
    String? id,
    String? token,
    String? userId,
    int? duration,
    DateTime? expiresAt,
    DateTime? createdAt,
    bool? valid,
  }) {
    return OtpResponse(
      id: id ?? this.id,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      duration: duration ?? this.duration,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      valid: valid ?? this.valid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'token': token,
      'userId': userId,
      'expiresAt': expiresAt.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'valid': valid,
    };
  }

  factory OtpResponse.fromMap(Map<String, dynamic> map) {
    return OtpResponse(
      id: map['id'] as String,
      token: map['token'] as String,
      userId: map['userId'] as String,
      duration: int.parse(map['duration']),
      expiresAt: DateTime.parse(map['expiresAt'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
      valid: map['valid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpResponse.fromJson(String source) => OtpResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OtpResponse(id: $id, token: $token, userId: $userId, durarion: $duration, expiresAt: $expiresAt, createdAt: $createdAt, valid: $valid)';
  }

  @override
  bool operator ==(covariant OtpResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.token == token &&
      other.userId == userId &&
      other.duration == duration &&
      other.expiresAt == expiresAt &&
      other.createdAt == createdAt &&
      other.valid == valid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      token.hashCode ^
      userId.hashCode ^
      duration.hashCode ^
      expiresAt.hashCode ^
      createdAt.hashCode ^
      valid.hashCode;
  }
}
