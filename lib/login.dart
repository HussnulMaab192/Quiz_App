// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:biit_quizz/homepage.dart';
import 'package:biit_quizz/loginerror.dart';
import 'package:biit_quizz/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  loginUser() async {
    try {
      UserCredential uc = await auth.signInWithEmailAndPassword(
          email: emailCont.text, password: pswdCount.text);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    } on Exception {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginError()));
    }
  }

  TextEditingController emailCont = new TextEditingController(); // to fetch the
  // data from the email text field
  TextEditingController pswdCount = new TextEditingController();

  GlobalKey<FormState> formkey =
      GlobalKey<FormState>(); // form validation k lye 1 key hota .
  // jb submit button py click karaain gay tu yh btaye ga k current state kia hai form ki

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BIIT QUIZZ'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formkey, // above declared global key ko link kia ha form k sath
          child: ListView(
            children: [
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Your Email';
                  }
                },
                controller: emailCont,
                decoration: InputDecoration(labelText: "Enter Email "),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Your Pswd';
                  }
                  if (value.length < 6) {
                    return 'Enter atleast 6 charachters ';
                  }
                },
                controller: pswdCount,
                decoration: InputDecoration(labelText: "Enter Password "),
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  // agr oper waly validator ki value theek hai tu tb
                  // control below waly if ko chalaye ga wrna error dai ga .
                  if (formkey.currentState!.validate()) {
                    loginUser();
                  }
                },
                height: 50,
                color: Colors.purple,
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}
