/// settings_page.dart
/// A page that displays settings for the app.
/// @author Jacob Rohde

import 'package:flutter/material.dart';
import 'package:the_coffee_and_code/pages/videos_page.dart';

import '../main.dart';
import 'coffee_journal_page.dart';
import 'coffee_time_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  //AppTheme theme = AppTheme();
  bool themeIsOn = false;
  // Color mainColor = const Color.fromARGB(255, 0, 255, 0);
  // Color backgroundColor = Colors.black;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings', style: TextStyle(color: theme.textColor)),
          backgroundColor: theme.barColor,
          iconTheme: IconThemeData(color: theme.textColor),
        ),
        body: Center(
            child: Container(
                decoration: BoxDecoration(color: theme.backgroundColor),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        children: [

                      Row(
                        children: [
                          Text('Light Mode: ',
                              style: TextStyle(
                                  color: theme.textColor,
                                  fontSize: 25.0,
                                  fontFamily: 'CutiveMono')
                          ),

                          Switch(
                            onChanged: (isOn) {
                              theme.switchTheme();

                              setState(() {
                                themeIsOn = isOn;
                              });
                            },
                            value: !theme.isDark,
                            inactiveThumbColor: const Color.fromARGB(255, 0, 255, 0),
                            inactiveTrackColor: const Color.fromARGB(255, 0, 100, 0),

                          )
                        ]
                      ),
                      Row(),
                    ]
                    )
                )
            )
        ),
      drawer: Drawer(
          backgroundColor: theme.backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(child: Image.asset('assets/BC_CoffeeLogo.png')),
              ListTile(
                  title: Text("Coffee Time", style: TextStyle(color: theme.textColor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return const CoffeeTime();
                    }));
                  }
              ),
              ListTile(
                  title: Text("Videos", style: TextStyle(color: theme.textColor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return const VideosPage();
                    }));
                  }
              ),
              ListTile(
                title: Text("Journal", style: TextStyle(color: theme.textColor)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return MainJournal();
                  }));
                },
              ),
              ListTile(
                title: Text("Settings", style: TextStyle(color: theme.textColor)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return const SettingsPage();
                  }));
                },
              )
            ],
          )
      ),
    );
  }
}