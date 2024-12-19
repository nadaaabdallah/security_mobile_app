import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:security_home_app/main.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 133, 121, 121).withOpacity(0.6),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/home.jpg"),
              alignment: Alignment.center,
              fit: BoxFit.cover,
              opacity: 0.4,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                child: Text(
                  "Let's Get Started",
                  style: TextStyle(
                    color: Color.fromARGB(255, 229, 219, 201),
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                  ),
                ),
                minSize: 40,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                color: Color.fromARGB(255, 101, 105, 111),
                borderRadius: BorderRadius.circular(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
