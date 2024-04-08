import 'package:flutter/material.dart';
import 'package:fl_ecommerce/models/user.dart'; // Import model
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  void toggleShowPassword() {
    showPassword = !showPassword;
  }

void login(BuildContext context) async {
  // Mendapatkan username dan password dari TextField
  String username = usernameController.text;
  String password = passwordController.text;

  // Cek apakah username dan password sesuai
  if (username == 'suryo' && password == '12345678') {
    // Simpan nama pengguna ke shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);

    // Jika sesuai, navigasi ke /landing
    Navigator.pushReplacementNamed(context, '/landing');
  } else {
    // Jika tidak sesuai, tampilkan pesan kesalahan (opsional)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Username atau password salah.'),
      duration: Duration(seconds: 2),
    ));
  }
}

}
