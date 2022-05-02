import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/buttons.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _userEmail = "";
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
          decoration: BoxDecoration(color: Colors.black),
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
            children: <Widget>[
              _createTitleText(),
              _createTextField(),
              _createSendRequestButton(context)
            ],
          )))),
    );
  }

  _createTitleText() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 100),
        child: Text('Forgot Password?', style: consoleTextHeader));
  }

  _createTextField() {
    return Container(
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
        ));
  }

  _createSendRequestButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: ConsoleButton(
                label: "Go Back",
                onTap: () {
                  Navigator.pop(context);
                })),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: ConsoleButton(
                label: 'Send email!',
                onTap: () {
                  _onRequest(context);
                }))
      ],
    );
  }

  _onRequest(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _userEmail);
      Timer(const Duration(seconds: 3), () => Navigator.of(context).pop());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'unknown') {
        _alertDialog(context, 'email-not-entered');
      } else {
        _alertDialog(context, e.code);
      }
    }
  }

  _alertDialog(BuildContext context, String errorCode) {
    showDialog<String>(
        context: context,
        barrierColor: Color.fromRGBO(0, 255, 0, 0.5),
        builder: (BuildContext context) => AlertDialog(
              title: Text('Warning!', style: consoleTextHeader),
              content: Text(
                  'The email you have entered is invalid! Error: ' + errorCode,
                  style: consoleTextBody),
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
}
