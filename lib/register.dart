// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _RegisterState extends State<Register> {
  // ignore: prefer_final_fields

  TextEditingController userNameCount = TextEditingController();
  TextEditingController emailCount = TextEditingController();
  TextEditingController pswrdCount = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  registerUser() async {
    // async ap ko hang hony aur rokny say bachata hai .
    // agr ham sync use karay gay tu wait karna pary ga .. pehly jis ki bari hogi woh execute
    // hoga then jab iski bari aye gi tab yh execute hoga .
    // await say yh background pr apni working karta rehta hai wait nai krta .
    await auth.createUserWithEmailAndPassword(
        email: emailCount.text, password: pswrdCount.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Text(
                "Register",
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
                    return 'User name cant be empty !';
                  }
                  if (value.length < 3) {
                    return 'user name must contain atleast 3 charaachters!';
                  }
                },
                controller: userNameCount,
                decoration: InputDecoration(labelText: "Enter User Name "),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email cant be empty !';
                  }
                },
                controller: emailCount,
                decoration: InputDecoration(labelText: "Enter Email "),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pswrdCount,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password cant be empty !';
                  }
                  if (value.length < 6) {
                    return 'Password must contain atleast 6 charaachters!';
                  }
                },
                decoration: InputDecoration(labelText: "Enter Password"),
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password cant be empty !';
                  }
                  // ignore: unrelated_type_equality_checks
                  if (value != pswrdCount.text) {
                    return 'Password not matched!!';
                  }
                },
                decoration: InputDecoration(labelText: "Confirm Password "),
                obscureText: true,
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    registerUser();
                  }
                },
                height: 50,
                color: Colors.purple,
                child: Text(
                  "Go",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
