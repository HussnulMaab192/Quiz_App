// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firebase = FirebaseFirestore.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  int score = 0;
  int countElement = 0;
  List<String> questions = List.generate(20, (index) => '');
  List<String> answers = List.generate(20, (index) => '');
  String name = '';
  @override
  @override
  // calls when screen loads .
  void initState() {
    firebase.collection("quiz").get().then((querySnapshot) => {
          querySnapshot.docs.forEach((document) {
            setState(() {
              name = document['Name'];
            });
          })
        });
    firebase.collection("questions").get().then((querySnapshot) => {
          querySnapshot.docs.forEach((document) {
            setState(() {
              questions[countElement] = document['Q'];
              answers[countElement] = document['A'];
              countElement++;
            });
          })
        });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(title: Text('${name}')),
      body: Center(
          child: count == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Instructions :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Question will be displaye one by one.\nAll Questions have one correct answers .\nPress the option button to give your answers\n",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          count++;
                        });
                      },
                      color: Colors.purple,
                      height: 80,
                      minWidth: 250,
                      child: Text(
                        'Start Quiz ',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ],
                )
              : Container(
                  // ignore: prefer_const_literals_to_create_immutables
                  child: count > countElement
                      ? Text(
                          "Quiz Finished!!\n\nYour Marks are :\t${score}",
                          style: TextStyle(
                              fontSize: 29,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Question # ${count} ",
                              style: TextStyle(fontSize: 40),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${questions[count - 1]}",
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  if (answers[count - 1] == "YES") {
                                    score++;
                                  }
                                  count++;
                                });
                              },
                              color: Color.fromRGBO(156, 39, 176, 1),
                              height: 50,
                              minWidth: 30,
                              child: Text(
                                'YES',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  if (answers[count - 1] == "NO") {
                                    score++;
                                  }
                                  count++;
                                });
                              },
                              color: Colors.purple,
                              height: 50,
                              minWidth: 30,
                              child: Text(
                                ' NO ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Score : ${score}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                )),
    );
  }
}
