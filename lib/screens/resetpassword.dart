import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class ResetPasswordScreen extends StatefulWidget {
  final String email;
  ResetPasswordScreen({required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _resetCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function to handle password reset
  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      final String resetCode = _resetCodeController.text;
      final String newPassword = _newPasswordController.text;

      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:5000/api/auth/resetpassword'), // Adjust the backend URL
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': widget.email,
            'resetCode': resetCode,
            'newPassword': newPassword,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password reset successfully')),
          );
          // Navigate to login screen or another page
        } else {
          final responseBody = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseBody['message']}')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _resetCodeController,
                decoration: InputDecoration(labelText: 'Enter Reset Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the reset code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'Enter New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
