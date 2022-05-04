/// edit_journal_page.dart
/// A page that allows users to edit previously created journal entries.
/// The page is accessed from coffee_journal_page.dart.
/// @author Spencer Leisch
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controller/BCController.dart';
import '../main.dart';
import 'add_journal_page.dart';

String body = "";
String title = "";
int date = 0;

class EditEntry extends StatefulWidget {
  const EditEntry({Key? key}) : super(key: key);
  @override
  State<EditEntry> createState() => _EditEntry();
}

class _EditEntry extends State<EditEntry> {
  StressFreeController controllerRef = StressFreeController();



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
                        child: TextFormField(
                          cursorColor: theme.mainColor,
                          style: TextStyle(color: theme.textColor),
                          initialValue: title, ///this makes the initial value display as the previous title.
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
                          controllerRef.editJournalData(title, date, body);
                          Navigator.pop(context); //submits the completed journal
                        }
                      },
                      style: saveButtonStyle,
                    )
                  ]),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
                    child: TextFormField(
                      cursorColor: theme.mainColor,
                      maxLines: null,
                      style: TextStyle(color: theme.textColor),
                      initialValue: body,
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

openEdit(String prevTitle, String prevBody, int prevDate) {
  title = prevTitle;
  body = prevBody;
  date = prevDate;
  prevTitle = prevTitle;
  return const EditEntry();
}