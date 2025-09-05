// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class OtpValidationResponse {
  final bool valid;

  OtpValidationResponse({
    required this.valid,
  });

  OtpValidationResponse copyWith({
    bool? valid,
  }) {
    return OtpValidationResponse(
      valid: valid ?? this.valid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'valid': valid,
    };
  }

  factory OtpValidationResponse.fromMap(Map<String, dynamic> map) {
    return OtpValidationResponse(
      valid: map['valid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpValidationResponse.fromJson(String source) => OtpValidationResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OtpValidationResponse(valid: $valid)';

  @override
  bool operator ==(covariant OtpValidationResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.valid == valid;
  }

  @override
  int get hashCode => valid.hashCode;
}
