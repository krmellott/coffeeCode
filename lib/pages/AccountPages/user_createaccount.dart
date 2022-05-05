import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/buttons.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final firestoreInstance = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String _userEmail = "";
  String _userPass = "";
  String _userPassVerification = "";
  final TextStyle consoleTextBody = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'BrokenConsole',
      color: Color.fromARGB(225, 0, 255, 0));
  final TextStyle consoleTextHeader = const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'BrokenConsole',
      color: Color.fromARGB(225, 0, 255, 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: 1000,
          height: 5000,
          decoration: const BoxDecoration(color: Colors.black),
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
            children: <Widget>[
              _createWelcomeText(),
              _createTextFields(),
              _createSignUpButton(context)
            ],
          )))),
    );
  }

  _createWelcomeText() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 100),
        child: Text('Welcome!', style: consoleTextHeader));
  }

  _createTextFields() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(225, 0, 255, 0)),
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 255, 0), width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(225, 0, 255, 0), width: 2.0),
                  ),
                  labelText: 'Please enter your email!',
                  labelStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(225, 0, 255, 0)),
                  filled: true,
                  fillColor: Colors.black),
              onChanged: (String? email) {
                setState(() {
                  _userEmail = email!;
                });
              },
            )),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(225, 0, 255, 0)),
              obscureText: true,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(225, 0, 255, 0), width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(225, 0, 255, 0), width: 2.0)),
                labelText: 'New Password',
                labelStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(225, 0, 255, 0)),
                filled: true,
                fillColor: Colors.black,
              ),
              onChanged: (String? password) {
                setState(() {
                  _userPass = password!;
                });
              },
            )),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(225, 0, 255, 0)),
              obscureText: true,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(225, 0, 255, 0), width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(225, 0, 255, 0), width: 2.0)),
                labelText: 'Retype Password',
                labelStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(225, 0, 255, 0)),
                filled: true,
                fillColor: Colors.black,
              ),
              onChanged: (String? passVerify) {
                setState(() {
                  _userPassVerification = passVerify!;
                });
              },
            ))
      ],
    );
  }

  _createSignUpButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: ConsoleButton(
                    label: "Go Back",
                    onTap: () {
                      Navigator.pop(context);
                    })),
            ConsoleButton(
                label: "Create Account",
                onTap: () {
                  _signUpAction(context);
                })
          ],
        ));
  }

  _signUpAction(BuildContext context) async {
    if (_isValidForm()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _userEmail, password: _userPass);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _alertDialog(context, 'Your password was too weak!');
        } else if (e.code == 'email-already-in-use') {
          _alertDialog(context, 'This email is already in use!');
        }
      }
    } else if (_userPass != _userPassVerification) {
      _alertDialog(context, "Your passwords do not match!");
    } else if ((_userEmail == "") ||
        (_userPass == "") ||
        (_userPassVerification == "")) {
      _alertDialog(context, "You left one or more fields empty!");
    }
  }

  _alertDialog(BuildContext context, String body) {
    showDialog<String>(
        context: context,
        barrierColor: const Color.fromRGBO(0, 255, 0, 0.5),
        builder: (BuildContext context) => AlertDialog(
              title: Text('Warning!', style: consoleTextHeader),
              content: Text(body, style: consoleTextBody),
              backgroundColor: Colors.black,
              actions: [
                Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: ConsoleButton(
                        label: "OK",
                        onTap: () {
                          Navigator.pop(context);
                        }))
              ],
            ));
  }

  bool _isValidForm() {
    return (!((_userEmail == "") &&
            (_userPass == "") &&
            (_userPassVerification == "")) &&
        (_userPass == _userPassVerification));
  }
}
