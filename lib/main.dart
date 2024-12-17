import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:security_home_app/screens/homepage.dart';
import 'package:security_home_app/screens/signup.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Security Home App',
      home: HomePageScreen(), // Start with LoginScreen
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay with opacity
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          // Login Content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  const Text(
                    'SECURE YOUR\nHOME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 199, 198, 205),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Login Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign Into',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'Manage Your Device & Accessory',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 77, 76, 76),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Email Input
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(CupertinoIcons.mail),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password Input
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(CupertinoIcons.lock),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              String email = _emailController.text;
  String password = _passwordController.text;

  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
       String token = responseBody['token'];
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login successful'),
        backgroundColor: Colors.green,
      ));

      // Store token and navigate to home page
      // Use the token for further authentication if needed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SmartHomeApp()),
      );
    } else {
      // Show error message
    String errorMessage = responseBody['error'] ?? 'An error occurred';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ));
    }
  } catch (e) {
    print("Error during login: $e");
    // Show error message if the request fails
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Network error or incorrect credentials'),
      backgroundColor: Colors.red,
    ));
  }
},
  

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey[700],
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Log in',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign Up Link
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to SignUpScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePageScreen()),
                              );
                            },
                            child: TextButton(
  onPressed: () {
    // Navigate to SignUpScreen when the button is pressed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  },
  child: const Text(
    "Don't have an account yet? Create an account",
    style: TextStyle(
      color: Colors.blueAccent,
      decoration: TextDecoration.underline,
    ),
  ),
),

                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 