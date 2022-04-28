import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_coffee_and_code/model/BCModel.dart';

class CoffeeTime extends StatefulWidget {
  const CoffeeTime({Key? key}) : super(key: key);

  @override
  _CoffeeTime createState() => _CoffeeTime();
}

class _CoffeeTime extends State<CoffeeTime> {
  String timeForCoffee = "";
  String sortMethod = "";
  final reference = BrunchClubModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View by Coffee Time'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(children: [
            Row(
              children: [
                DropdownButton<String>(
                    hint: const Text('Choose a Time'),
                    items: <String>[
                      'In the morning',
                      'Before coding',
                      'While coding',
                      'Before and while coding',
                      'After coding',
                      'All the time',
                      'No specific time'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    //credit to Pravin Raj and user1032613 on stack overflow
                    onChanged: (value) {
                      setState(() {
                        timeForCoffee = value.toString();
                      });
                    }),
                DropdownButton(
                    hint: const Text('Sort by'),
                    items: <String>[
                      'Coffee cups ascending',
                      'Coffee cups descending',
                      'Coding hours ascending',
                      'Coding hours descending'
                    ].map((String sort) {
                      return DropdownMenuItem<String>(
                        value: sort,
                        child: Text(sort),
                      );
                    }).toList(),
                    onChanged: (sort) {
                      setState(() {
                        sortMethod = sort.toString();
                      });
                    }),
              ],
            ),
            _sortedData(sortMethod, timeForCoffee, context)
          ]),
        ),
      ),
    );
  }

  Widget _displayCupsAndHours(BuildContext context, DocumentSnapshot doc) {
    var docData = doc.data() as Map<String, dynamic>;

    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: Colors.black,
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    'Cups of Coffee per Day: ' +
                        docData['coffeeCupsPerDay'].toString(),
                    style: const TextStyle(color: Colors.lightGreenAccent),
                  )),
              Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    'Coding Hours: ' + docData['codingHours'].toString(),
                    style: const TextStyle(color: Colors.lightGreenAccent),
                  )),
            ],
          ),
        ));
  }

  _sortedData(String method, String time, BuildContext buildContext) {
    switch (method) {
      case 'Coffee cups ascending':
        return Expanded(
          child: StreamBuilder(
            stream: reference
                .orderedUserDataWithSort('coffeeCupsPerDay', true)
                .where((coffeeTime) => false),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) => _displayCupsAndHours(
                        context, snapshot.data.docs[index]));
              }
            },
          ),
        );
      case 'Coffee cups descending':
        return Expanded(
          child: StreamBuilder(
            stream: reference
                .orderedUserDataWithSort('coffeeCupsPerDay', false)
                .where((coffeeTime) => false),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) => _displayCupsAndHours(
                        context, snapshot.data.docs[index]));
              }
            },
          ),
        );
      case 'Coding hours ascending':
        return Expanded(
          child: StreamBuilder(
            stream: reference
                .orderedUserDataWithSort('codingHours', true)
                .where((coffeeTime) => false),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) => _displayCupsAndHours(
                        context, snapshot.data.docs[index]));
              }
            },
          ),
        );
      case 'Coding hours descending':
        return Expanded(
          child: StreamBuilder(
            stream: reference
                .orderedUserDataWithSort('codingHours', true)
                .where((coffeeTime) => false),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) => _displayCupsAndHours(
                        context, snapshot.data.docs[index]));
              }
            },
          ),
        );
    }
  }
}
