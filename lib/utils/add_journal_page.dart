/// add_journal_page.dart
/// A page that allows users to create and add journal entries to the database.
/// The page is accessed from coffee_journal_page.dart.
/// @author Spencer Leisch
import 'package:flutter/material.dart';

import '../controller/BCController.dart';
import '../main.dart';

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
      primary: theme.backgroundColor,
      side: BorderSide(color: theme.mainColor, width: 2),
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Journal Entry",
              style: TextStyle(color: theme.textColor)),
          backgroundColor: theme.barColor,
          iconTheme: IconThemeData(color: theme.textColor),
        ),
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                  color: theme.backgroundColor,
                ),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 10, top: 10),
                        child: TextField(
                          cursorColor: theme.mainColor,
                          style: TextStyle(color: theme.textColor),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: theme.mainColor, width: 2),
                              //borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: theme.mainColor, width: 2),
                            ),
                            labelText: 'Title your journal!',
                            labelStyle: TextStyle(color: theme.textColor),
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
                      child: Text('Save',
                          style: TextStyle(color: theme.textColor)),
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
                      cursorColor: theme.mainColor,
                      maxLines: null,
                      style: TextStyle(color: theme.textColor),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Tell us about your coffee and coding!',
                        labelStyle: TextStyle(color: theme.textColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.mainColor, width: 2),
                          //borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.mainColor, width: 2),
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

/// Creates and manages the alert dialog that tells users to fill in
/// all fields, thus preventing users from submitting empty journals.
showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK", style: TextStyle(color: theme.textColor)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(
        "It seems you left a field blank. Please fill it out to save your journal.",
        style: TextStyle(color: theme.textColor)),
    backgroundColor: theme.backgroundColor,
    shape: BeveledRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      side: BorderSide(color: theme.mainColor, width: 1.5),
    ),
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
