import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_coffee_and_code/model/BCModel.dart';
import 'package:the_coffee_and_code/pages/coffee_journal_page.dart';
import 'package:the_coffee_and_code/pages/videos_page.dart';

import '../utils/video_player.dart';

class CoffeeTime extends StatefulWidget {
  const CoffeeTime({Key? key}) : super(key: key);

  @override
  _CoffeeTime createState() => _CoffeeTime();
}

class _CoffeeTime extends State<CoffeeTime> {
  String timeForCoffee = 'In the morning';
  String sortMethod = 'Coffee cups ascending';
  final reference = BrunchClubModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View by Coffee Time'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Text('Choose a Time',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 255, 0),
                        fontFamily: 'CutiveMono')),
              ),
              Padding(
                padding: EdgeInsets.only(right: 60),
                child: DropdownButton<String>(
                    hint: const Text('Choose a Time'),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 255, 0),
                        fontFamily: 'CutiveMono'),
                    dropdownColor: Colors.black,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 0, 255, 0),
                    ),
                    value: timeForCoffee,
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
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Text('Sort by',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 255, 0),
                        fontFamily: 'CutiveMono')),
              ),
              Padding(
                padding: EdgeInsets.only(right: 60),
                child: DropdownButton(
                    hint: const Text('Sort by'),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 255, 0),
                        fontFamily: 'CutiveMono'),
                    dropdownColor: Colors.black,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 0, 255, 0),
                    ),
                    value: sortMethod,
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
              )
            ]),
            _sortedData(sortMethod, timeForCoffee, context)
          ]),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(child: Image.asset('assets/BC_CoffeeLogo.png')),
              ListTile(
                  title: const Text("Coffee Time", style: TextStyle(color: Colors.green)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return const CoffeeTime();
                    }));
                  }
              ),
              ListTile(
                  title: const Text("Videos", style: TextStyle(color: Colors.green)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return const VideosPage();
                  }));
                }
              ),
              ListTile(
                title: const Text("Journal", style: TextStyle(color: Colors.green)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return MainJournal();
                  }));
                },
              )
            ],
          )
      ),
    );
  }

  Widget _displayCupsAndHours(BuildContext context, DocumentSnapshot doc) {
    var docData = doc.data() as Map<String, dynamic>;
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: Colors.black,
          child: ListTile(
            title: Text(
              "Cups of Coffee per Day: " +
                  docData['coffeeCupsPerDay'] +
                  "\n" +
                  "Coding Hours: " +
                  docData['codingHours'],
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 255, 0),
                  fontFamily: 'CutiveMono'),
            ),
          ),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 255, 0), width: 1)),
        ));
  }

  _sortedData(String method, String time, BuildContext buildContext) {
    switch (method) {
      case 'Coffee cups ascending':
        return Expanded(
          child: StreamBuilder(
            stream:
                reference.orderedUserDataWithSort('coffeeCupsPerDay', false),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                List sortedItems = [];
                for (int i = 0; i < 100; i++) {
                  String coffeesTime =
                      snapshot.data.docs[i]['coffeeTime'].toString();
                  if (coffeesTime == time) {
                    sortedItems.add(snapshot.data.docs[i]);
                  }
                }
                return ListView.builder(
                    itemCount: sortedItems.length,
                    itemBuilder: (context, index) =>
                        _displayCupsAndHours(context, sortedItems[index]));
              }
            },
          ),
        );
      case 'Coffee cups descending':
        return Expanded(
          child: StreamBuilder(
            stream: reference.orderedUserDataWithSort('coffeeCupsPerDay', true),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                List sortedItems = [];
                for (int i = 0; i < 100; i++) {
                  String coffeesTime =
                      snapshot.data.docs[i]['coffeeTime'].toString();
                  if (coffeesTime == time) {
                    sortedItems.add(snapshot.data.docs[i]);
                  }
                }
                return ListView.builder(
                    itemCount: sortedItems.length,
                    itemBuilder: (context, index) =>
                        _displayCupsAndHours(context, sortedItems[index]));
              }
            },
          ),
        );
      case 'Coding hours ascending':
        return Expanded(
          child: StreamBuilder(
            stream: reference.orderedUserDataWithSort('codingHours', false),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                List sortedItems = [];
                for (int i = 0; i < 100; i++) {
                  String coffeesTime =
                      snapshot.data.docs[i]['coffeeTime'].toString();
                  if (coffeesTime == time) {
                    sortedItems.add(snapshot.data.docs[i]);
                  }
                }
                return ListView.builder(
                    itemCount: sortedItems.length,
                    itemBuilder: (context, index) =>
                        _displayCupsAndHours(context, sortedItems[index]));
              }
            },
          ),
        );
      case 'Coding hours descending':
        return Expanded(
          child: StreamBuilder(
            stream: reference.orderedUserDataWithSort('codingHours', true),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                List sortedItems = [];
                for (int i = 0; i < 100; i++) {
                  String coffeesTime =
                      snapshot.data.docs[i]['coffeeTime'].toString();
                  if (coffeesTime == time) {
                    sortedItems.add(snapshot.data.docs[i]);
                  }
                }
                return ListView.builder(
                    itemCount: sortedItems.length,
                    itemBuilder: (context, index) =>
                        _displayCupsAndHours(context, sortedItems[index]));
              }
            },
          ),
        );
    }
  }
}
