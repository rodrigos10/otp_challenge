import 'package:flutter/material.dart';
import 'package:otp_generator/shared/providers/otp_datasource.dart';
import 'package:otp_generator/shared/providers/otp_percent_provider.dart';
import 'package:otp_generator/shared/providers/user_datasource.dart';
import 'package:otp_generator/shared/routes.dart';
import 'package:otp_generator/views/cadastro_screen.dart';
import 'package:otp_generator/views/home_screen.dart';
import 'package:otp_generator/views/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OtpPercentProvider()),
        ChangeNotifierProvider(create: (_) => OtpDatasource()),
        ChangeNotifierProvider(create: (_) => UserDatasource()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.home: (ctx) => HomeScreen(),
          AppRoutes.login: (ctx) => LoginScreen(),
          AppRoutes.cadastro: (ctx) => CadastroScreen(),
        },
      ),
    );
  }
}
