import 'package:flutter/material.dart';
import 'package:fl_ecommerce/controllers/login_controller.dart'; // Import controller

class LoginPage extends StatelessWidget {
  final LoginController controller = LoginController(); // Instantiate controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: controller.usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(controller.showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    controller.toggleShowPassword();
                  },
                ),
              ),
              obscureText: !controller.showPassword,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                controller.login(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
