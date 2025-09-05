import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:otp_generator/shared/model/cadastro_response.dart';
import 'package:otp_generator/shared/model/login_response.dart';
import 'package:otp_generator/shared/providers/base_datasource.dart';
import 'package:otp_generator/shared/routes.dart';

class UserDatasource extends ChangeNotifier with BaseDatasource {
  LoginResponse? _currentUser;
  String _email = '';
  String _password = '';
  String _userName = '';

  LoginResponse? get currentUser => _currentUser;
  String get email => _email;
  String get password => _password;
  String get userName => _userName;

  set updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  set updateUserName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  set updateCurrentUser(LoginResponse? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<LoginResponse> login(BuildContext ctx) async {
    var uri = Uri.parse('$baseUrl/user/login');

    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': _email, 'password': _password}),
    );

    if (response.statusCode == 200) {

      updateCurrentUser = LoginResponse.fromJson(response.body);

      notifyListeners();

      return Future.value(_currentUser);
    } else if (response.statusCode == 404) {
      Navigator.pushReplacementNamed(ctx, AppRoutes.cadastro);
      return Future.value(null);
    } else {
      throw Exception('Erro ao realizar o login!');
    }
  }

    Future<CadastroResponse> cadastro(BuildContext ctx) async {
    var uri = Uri.parse('$baseUrl/user');

    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': _email, 'password': _password, 'userName': _userName}),
    );

    if (response.statusCode == 200) {

      Navigator.pushReplacementNamed(ctx, AppRoutes.home);

      return Future.value(CadastroResponse.fromJson(response.body));
    } else {
      throw Exception('Erro ao realizar o login!');
    }
  }
}
