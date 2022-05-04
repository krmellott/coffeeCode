/// coffee_journal_page.dart
/// Page where users can view all previous journals they have made, as well as
/// choose to delete them or add a new entry.
/// @author Spencer Leisch

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_coffee_and_code/pages/settings_page.dart';
import 'package:the_coffee_and_code/pages/videos_page.dart';
import 'package:the_coffee_and_code/utils/add_journal_page.dart';
import 'package:flutter/material.dart';
import 'package:the_coffee_and_code/controller/BCController.dart';

import '../main.dart';
import '../utils/add_journal_page.dart';
import '../utils/app_drawer.dart';
import '../utils/edit_journal_page.dart';
import 'coffee_time_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainJournal());
}



///important variables
final journalsRef = FirebaseFirestore.instance.collection('journal');
final StressFreeController controllerRef = StressFreeController();

class MainJournal extends StatefulWidget {
  const MainJournal({Key? key}) : super(key: key);

  @override
  _MainJournal createState() => _MainJournal();
}

class _MainJournal extends State<MainJournal> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal', style: TextStyle(color: theme.textColor)),
        backgroundColor: theme.barColor,
        iconTheme: IconThemeData(color: theme.textColor),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
          color: theme.backgroundColor,
        ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 5.0),
              child: Text("Your Journals", // the title
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: theme.textColor,
                  )),
            ),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('journal')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Text("We didn't find any journals for you");
                      }
                      final data = snapshot.requireData;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.size,
                          itemBuilder: (context, index) {
                            return _buildJournalListItem(
                                context, data.docs[data.size - 1 - index]);

                            ///this is really dumb, but it makes the list auto sort to newest to oldest
                            ///please don't change this
                          });
                    })
            ),
            OutlinedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(50.0, 1.0, 50.0, 1.0)),
                backgroundColor: MaterialStateProperty.all<Color>(theme.backgroundColor),
                side: MaterialStateProperty.all(BorderSide(color: theme.mainColor, width: 2))
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const AddEntry();
                }));
              },
              //backgroundColor: Colors.green,
              child: Text('New Journal Entry', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textColor)),
            )
          ]),
        ),
      ),
      drawer: getDrawer(context),
    );
  }
}

///Creates a list of all journal in order of creation from most recent to least
///Returns a card consisting of the title and the body
Widget _buildJournalListItem(BuildContext context, DocumentSnapshot document) {
  var data = document.data() as Map<String, dynamic>;
  var date = DateTime.fromMillisecondsSinceEpoch(data['date']);
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: Card(
      child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
          title: Text(data['title'] +
              " --- " +
              date.month.toString() +
              "/" +
              date.day.toString() +
              "/" +
              date.year.toString(), style: TextStyle(color: theme.textColor),),
          subtitle: Text(data['body'], style: TextStyle(color: theme.textColor)),
          trailing: Column (
            children: [
              InkWell(
                child: Icon(Icons.edit, color: theme.mainColor),
                onTap: () {
                  showEditDialog(context, data['title'].toString(), data['body'].toString(), data['date']);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                child: Icon(Icons.cancel_presentation_sharp, color: theme.mainColor),
                onTap: () {
                  showDeleteDialog(context, data['title'].toString());
                },
              ),
            ],
          ),
          tileColor: theme.backgroundColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: theme.mainColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
      ),
    ),
  );
}
///shows the "do you want to delete this journal" dialog
showDeleteDialog(BuildContext context, String title) {
  Widget yesButton = TextButton(
    child: Text("YES", style: TextStyle(color: theme.textColor)),
    onPressed: () {
      controllerRef.removeJournalData('journal', title);
      Navigator.of(context).pop();
    },
  );
  Widget noButton = TextButton(
    child: Text("NO", style: TextStyle(color: theme.textColor)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Would you like to delete this journal entry?",
        style: TextStyle(color: theme.textColor)),
    backgroundColor: theme.backgroundColor,
    shape: BeveledRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      side: BorderSide(color: theme.mainColor, width: 1.5),
    ),
    actions: [
      yesButton,
      noButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
///shows the "do you want to edit this journal" dialog
showEditDialog(BuildContext context, String title, String body, int date) {
  Widget yesButton = TextButton(
    child: Text("YES", style: TextStyle(color: theme.textColor)),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return openEdit(title, body, date);
      }));
    },
  );
  Widget noButton = TextButton(
    child: Text("NO", style: TextStyle(color: theme.textColor)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Would you like to edit this journal entry?",
        style: TextStyle(color: theme.textColor)),
    backgroundColor: theme.backgroundColor,
    shape: BeveledRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      side: BorderSide(color: theme.mainColor, width: 1.5),
    ),
    actions: [
      yesButton,
      noButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}