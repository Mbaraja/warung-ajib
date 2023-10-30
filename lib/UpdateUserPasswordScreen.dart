import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserPasswordScreen extends StatefulWidget {
  @override
  _UpdateUserPasswordScreenState createState() =>
      _UpdateUserPasswordScreenState();
}

class _UpdateUserPasswordScreenState extends State<UpdateUserPasswordScreen> {
  final TextEditingController newUsernameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  void updateUserData() async {
    final newUsername = newUsernameController.text;
    final newPassword = newPasswordController.text;

    // Simpan username dan password baru ke SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
    await prefs.setString('password', newPassword);

    // Kembali ke halaman sebelumnya (misalnya, ProductListView)
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User & Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: newUsernameController,
              decoration: InputDecoration(labelText: 'New Username'),
            ),
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: updateUserData,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
