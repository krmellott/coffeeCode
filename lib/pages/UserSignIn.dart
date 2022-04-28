import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/buttons.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _userEmail = "";
  String _userPass = "";

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
            children: <Widget>[_createTextFields(), _createSendButton(context)],
          )))),
    );
  }

  _createTextFields() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 255, 0), width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(225, 0, 255, 0), width: 2.0),
                  ),
                  labelText: 'Please enter your email!',
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
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(225, 0, 255, 0), width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(225, 0, 255, 0), width: 2.0)),
                labelText: 'Password',
                filled: true,
                fillColor: Colors.black,
              ),
              onChanged: (String? password) {
                setState(() {
                  _userPass = password!;
                });
              },
            ))
      ],
    );
  }

  _createSendButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: MyButton(
            label: 'Log In!',
            onTap: () {
              _onSignIn(context);
            }));
  }

  _onSignIn(BuildContext context) async {
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _userEmail, password: _userPass);
      if (user.user!.uid != "") {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (BuildContext context) {
        //   return Home();
        print('going to next page');
        //}
        //));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } finally {
      //  print(userCredential.user.uid);
    }
  }
}
