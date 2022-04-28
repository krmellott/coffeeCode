import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_coffee_and_code/utils/add_journal_page.dart';
import 'package:flutter/material.dart';
import 'package:the_coffee_and_code/controller/BCController.dart';

import '../utils/add_journal_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: defaultFirebaseOptions);
  runApp(MainJournal());
}

///important variables
final journalsRef = FirebaseFirestore.instance.collection('journal');
final StressFreeController controllerRef = StressFreeController();

class MainJournal extends StatefulWidget {
  @override
  _MainJournal createState() => _MainJournal();
}

class _MainJournal extends State<MainJournal> {
  String dropDownValue = "default";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.lightBlueAccent, Colors.white])),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 5.0),
              child: Text("Your Journals", // the title
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                        return Text("We didn't find any journals for you");
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
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.fromLTRB(50.0, 1.0, 50.0, 1.0)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return AddEntry();
                }));
              },
              //backgroundColor: Colors.green,
              child: const Text('New Journal Entry', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            )
          ]),
        ),
      ),

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
          contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
          title: Text(data['title'] +
              " --- " +
              date.month.toString() +
              "/" +
              date.day.toString() +
              "/" +
              date.year.toString()),
          subtitle: Text(data['body']),
          trailing: TextButton(
            child: Icon(Icons.cancel_sharp, color: Colors.red),
            onPressed: () {
              showAlertDialog(context, data['title'].toString());
            },
          )),
    ),
  );
}

showAlertDialog(BuildContext context, String title) {
  Widget yesButton = TextButton(
    child: Text("YES"),
    onPressed: () {
      controllerRef.removeJournalData('journal', title);
      Navigator.of(context).pop();
    },
  );
  Widget noButton = TextButton(
    child: Text("NO"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Would you like to delete this journal entry?"),
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
