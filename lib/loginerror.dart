// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginError extends StatefulWidget {
  const LoginError({Key? key}) : super(key: key);

  @override
  _LoginErrorState createState() => _LoginErrorState();
}

class _LoginErrorState extends State<LoginError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Failed to Login"),
      ),
      body: Center(
          child: Text(
        "Login Failed!",
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.purple),
      )),
    );
  }
}
