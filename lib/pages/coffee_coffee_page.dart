import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';
import '../utils/app_drawer.dart';

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePage createState() => _CoffeePage();
}

class _CoffeePage extends State<CoffeePage> {
  String coffeeType = 'Americano';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Coffee Types', style: TextStyle(color: theme.textColor)),
          backgroundColor: theme.barColor,

          iconTheme: IconThemeData(color: theme.textColor),
        ),
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                  color: theme.backgroundColor,

                ),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text('Choose a coffee type',
                          style: TextStyle(
                            color: theme.textColor,
                            fontFamily: 'DroidSansMono',
                          )),
                    ),
                  ]
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: DropdownButton<String>(
                            hint: const Text('Choose a Time'),
                            style: TextStyle(
                                color: theme.textColor,
                                fontFamily: 'DroidSansMono'),
                            dropdownColor: theme.backgroundColor,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: theme.mainColor,
                            ),
                            value: coffeeType,
                            items: <String>[
                              'Americano',
                              'Caffe latte',
                              'Cappuccino',
                              'Double Espresso (Doppio)',
                              'Espresso (Short Black)',
                              'Nescafe',
                              'Turkish',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                coffeeType = value.toString();
                              });
                            })

                    )
                  ]),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('UserData').snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Text('Loading');
                        } else {
                          List sortedItems = [];
                          for (int i = 0; i < 100; i++) {
                            String type =
                            snapshot.data.docs[i]['coffeeType'].toString();
                            if (type == coffeeType) {
                              sortedItems.add(snapshot.data.docs[i]);
                            }
                          }

                          return ListView.builder(
                              itemCount: sortedItems.length,
                              itemBuilder: (context, index) =>
                                  _display(context, sortedItems[index]));
                        }
                      },
                    ),
                  ),
                ]
                ))),
    drawer: getDrawer(context),
    );
  }}

    Widget _display(BuildContext context, DocumentSnapshot doc){
      var docData = doc.data() as Map<String, dynamic>;
      return Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          color: theme.backgroundColor,
          child: ListTile(
            title: Text(
              "Age: " + docData['ageRange'] + "\n" +
              "Gender: " + docData['gender'] + "\n" +
              "Country: " + docData['country'] + "\n" +
              "Coffee Type: " + docData['coffeeType'] + "\n" +
              "Cups per day: " + docData['coffeeCupsPerDay'] + "\n" +
              "Coffee Time: " + docData['coffeeTime'] + "\n" +
              "Coding Hours: " + docData['codingHours'] + "\n",

              style: TextStyle(
                  color: theme.textColor,
                  fontFamily: 'DroidSansMono'),
            ),
            ),
          margin:
          const EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 1),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: theme.mainColor, width: 1)),
          ),
        );
    }



