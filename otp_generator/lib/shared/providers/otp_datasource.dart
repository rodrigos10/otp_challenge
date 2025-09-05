import 'package:flutter/foundation.dart';
import 'package:otp_generator/shared/model/otp_response.dart';
import 'package:otp_generator/shared/model/otp_validation_response.dart';
import 'package:otp_generator/shared/providers/base_datasource.dart';
import 'package:http/http.dart' as http;

class OtpDatasource extends ChangeNotifier with BaseDatasource {

  String _otpTyped = '';
  OtpResponse? _otpResponse;
  OtpValidationResponse _otpValidation = OtpValidationResponse(valid: false);
  int _duration = 15;

  OtpResponse? get otpResponse => _otpResponse;
  int get durarion => _duration;
  String get otTyped => _otpTyped;
  OtpValidationResponse get otpValidation => _otpValidation;

  set updateOtpTyped(String otp) {
    _otpTyped = otp;
    notifyListeners();
  }

  set updateDuration(int duration) {
    _duration = duration;
    notifyListeners();
  }

  Future<OtpResponse> fetchOtp() async {
    var uri = Uri.parse('$baseUrl/otp/$currentUserId');
    var response = await http.post(uri);

    if (response.statusCode == 200) {
      _otpResponse = OtpResponse.fromJson(response.body);
      notifyListeners();
      return _otpResponse!;
    } else {
      throw Exception('Erro ao gerar o código OTP!');
    }
  }

    Future<OtpValidationResponse> verifyOtp(String userId) async {

    var query = Uri(queryParameters: {'userId': userId}).query;

    var uri = Uri.parse('$baseUrl/otp/verify/$_otpTyped?$query');
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      _otpValidation = OtpValidationResponse.fromJson(response.body);
      notifyListeners();
      return _otpValidation!;
    } else {
      _otpValidation = OtpValidationResponse(valid: false);
      return _otpValidation;
    }
  }

}


