
import 'package:flutter/material.dart';

import '../controller/BCController.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  State<AddEntry> createState() => _AddEntry();
}

class _AddEntry extends State<AddEntry> {
  StressFreeController controllerRef = StressFreeController();
  String body = "";
  String title = "";

  final ButtonStyle saveButtonStyle = ElevatedButton.styleFrom(
    // ButtonStyle for the save button
      primary: Colors.green,
      textStyle: const TextStyle(fontSize: 20.0),
      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Journal Entry"),
        ),
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.lightBlueAccent, Colors.white])),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                      child: Container(
                        margin:
                        const EdgeInsets.only(left: 20, right: 10, top: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title your entry!',
                          ),
                          onChanged: (String? aTitle) {
                            setState(() {
                              title = aTitle!;
                            });
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {
                        if (body == "" || title == "") {
                          showAlertDialog(context); //displays ominous threat
                        } else {
                          controllerRef.insertJournalData(body,
                              DateTime.now().millisecondsSinceEpoch, title);
                          Navigator.pop(
                              context); //submits the completed journal
                        }
                      },
                      style: saveButtonStyle,
                    )
                  ]),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'What did you do today?',
                      ),
                      onChanged: (String? aBody) {
                        setState(() {
                          body = aBody!;
                        });
                      },
                    ),
                  ),
                ]))));
  }
}

/// Creates and manages the alert dialog that tells users to fill in
/// all fields, thus preventing users from submitting empty journals.
showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("It seems you left a field blank. Please fill it out to save your journal."),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
