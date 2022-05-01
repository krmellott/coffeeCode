import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_coffee_and_code/pages/coffee_journal_page.dart';
import 'package:the_coffee_and_code/pages/coffee_time_page.dart';

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
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: Builder(
            builder: (context) => Scaffold(
                  body: Container(
                      width: 1000,
                      height: 5000,
                      decoration: BoxDecoration(color: Colors.black),
                      child: SingleChildScrollView(
                          child: Center(
                              child: Column(
                        children: <Widget>[
                          _createLogo(),
                          _createTextFields(),
                          _createSendButton(context)
                        ],
                      )))),
                )));
  }

  _createLogo() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 200),
        child: Column(children: [
          const Text("Brunch Club Coffee",
              textScaleFactor: 2,
              style: TextStyle(
                  //fontSize: 32,
                  color: Color.fromARGB(255, 0, 255, 0),
                  fontFamily: 'BrokenConsole')),
          Image.asset('assets/BC_CoffeeLogo.png')
        ]));
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
                  labelStyle: const TextStyle(
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
                labelText: 'Password',
                labelStyle: const TextStyle(
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
    print("User trying to sign in!");
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _userEmail, password: _userPass);
      if (user.user!.uid != "") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return CoffeeTime();
        }));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user wasn't found");
      } else if (e.code == 'wrong-password') {
        print("incorrect password");
      }
    } finally {}
  }
}
