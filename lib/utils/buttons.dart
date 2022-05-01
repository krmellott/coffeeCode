import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }
}

class ConsoleButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  const ConsoleButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black,
            border: Border(
                top:
                    BorderSide(color: Color.fromARGB(255, 0, 255, 0), width: 2),
                left:
                    BorderSide(color: Color.fromARGB(255, 0, 255, 0), width: 2),
                right:
                    BorderSide(color: Color.fromARGB(255, 0, 255, 0), width: 2),
                bottom: BorderSide(
                    color: Color.fromARGB(255, 0, 255, 0), width: 2))),
        child: Text(
          label,
          style:
              TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 0, 255, 0)),
        ),
      ),
    );
  }
}
