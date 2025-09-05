import 'package:flutter/material.dart';
import 'package:otp_generator/shared/providers/user_datasource.dart';
import 'package:otp_generator/shared/routes.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDatasource>(context, listen: true);
    final emailController = TextEditingController(text: provider.email);
    final passwordController = TextEditingController(text: provider.password);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'User email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                try {

                  provider.updateEmail = emailController.text;
                  provider.updatePassword = passwordController.text;

                  await provider.login(context).then((result) {
                    if (context.mounted && result.userId.isNotEmpty) {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  });
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login failed: ${e.toString()}')),
                    );
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
