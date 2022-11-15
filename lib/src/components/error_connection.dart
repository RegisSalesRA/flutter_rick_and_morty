import 'package:flutter/material.dart';

class ErrorConnection extends StatelessWidget {
  const ErrorConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
        
            child: Column(children: [
          Image.asset(
            'assets/images/error.png',
            height: 350,
          ),
          const Text(
            "Error connection",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child: const Text(
              "Please check your internet connection or try again later!",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          )
        ])));
  }
}
