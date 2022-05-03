/// edit_journal_page.dart
/// A page that allows users to edit previously created journal entries.
/// The page is accessed from coffee_journal_page.dart.
/// @author Spencer Leisch
import 'package:flutter/material.dart';

import '../controller/BCController.dart';

class EditEntry extends StatefulWidget {
  const EditEntry({Key? key}) : super(key: key);
  @override
  State<EditEntry> createState() => _EditEntry();
}

class _EditEntry extends State<EditEntry> {
  StressFreeController controllerRef = StressFreeController();

  String body = "";
  String title = "";

  final ButtonStyle saveButtonStyle = ElevatedButton.styleFrom(
    // ButtonStyle for the save button
      primary: Colors.black,
      side: const BorderSide(color: Colors.green, width: 2),
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Journal Entry",
              style: TextStyle(color: Colors.green)),
          backgroundColor: Colors.black,
        ),
        body: Center(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                      child: Container(
                        margin:
                        const EdgeInsets.only(left: 20, right: 10, top: 10),
                        child: TextField(
                          cursorColor: Colors.green,
                          style: TextStyle(color: Colors.green),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.green, width: 2),
                              //borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.green, width: 2),
                            ),
                            labelText: 'Title your journal!',
                            labelStyle: TextStyle(color: Colors.green),
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
                      child: const Text('Save',
                          style: TextStyle(color: Colors.green)),
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
                      cursorColor: Colors.green,
                      maxLines: null,
                      style: TextStyle(color: Colors.green),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tell us about your coffee and coding!',
                        labelStyle: TextStyle(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                          //borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
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

void editJournalOpen(String title) {
  const EditEntry();
}

/// Creates and manages the alert dialog that tells users to fill in
/// all fields, thus preventing users from submitting empty journals.
showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK", style: TextStyle(color: Colors.green)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text(
        "It seems you left a field blank. Please fill it out to save your journal.",
        style: TextStyle(color: Colors.green)),
    backgroundColor: Colors.black26,
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
