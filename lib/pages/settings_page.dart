/// settings_page.dart
/// A page that displays settings for the app.
/// @author Jacob Rohde

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:the_coffee_and_code/pages/videos_page.dart';

import '../main.dart';
import '../utils/app_drawer.dart';
import 'coffee_journal_page.dart';
import 'coffee_time_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  bool themeIsOn = false;
  bool coffeeNotifIsOn = false;
  bool codeNotifIsOn = false;

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
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
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
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 40),
                            child: Column (
                                children: [

                                  Text('Notifications',
                                      style: TextStyle(
                                          color: theme.textColor,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'CutiveMono')
                                  ),

                                  Row(
                                      children: [
                                        Text('Coffee Info: ',
                                            style: TextStyle(
                                                color: theme.textColor,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'CutiveMono')
                                        ),

                                        OutlinedButton(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0)),
                                              backgroundColor: MaterialStateProperty.all<Color>(theme.backgroundColor),
                                              side: MaterialStateProperty.all(BorderSide(color: theme.mainColor, width: 2))
                                          ),
                                          onPressed: () async {
                                            print('coffee notifications on');
                                            await FirebaseMessaging.instance.subscribeToTopic("coffee");
                                          },
                                          //backgroundColor: Colors.green,
                                          child: Text('Subscribe', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textColor, fontFamily: 'CutiveMono')),
                                        ),

                                        OutlinedButton(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0)),
                                              backgroundColor: MaterialStateProperty.all<Color>(theme.backgroundColor),
                                              side: MaterialStateProperty.all(BorderSide(color: theme.mainColor, width: 2))
                                          ),
                                          onPressed: () async {
                                            print('coffee notifications off');
                                            await FirebaseMessaging.instance.unsubscribeFromTopic("coffee");
                                          },
                                          //backgroundColor: Colors.green,
                                          child: Text('Unsubscribe', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textColor, fontFamily: 'CutiveMono')),
                                        )
                                      ]
                                  ),

                                  Row(
                                      children: [
                                        Text('Coding Info: ',
                                            style: TextStyle(
                                                color: theme.textColor,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'CutiveMono')
                                        ),

                                        OutlinedButton(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0)),
                                              backgroundColor: MaterialStateProperty.all<Color>(theme.backgroundColor),
                                              side: MaterialStateProperty.all(BorderSide(color: theme.mainColor, width: 2))
                                          ),
                                          onPressed: () async {
                                            print('code notifications on');
                                            await FirebaseMessaging.instance.subscribeToTopic("code");
                                          },
                                          //backgroundColor: Colors.green,
                                          child: Text('Subscribe', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textColor, fontFamily: 'CutiveMono')),
                                        ),

                                        OutlinedButton(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0)),
                                              backgroundColor: MaterialStateProperty.all<Color>(theme.backgroundColor),
                                              side: MaterialStateProperty.all(BorderSide(color: theme.mainColor, width: 2))
                                          ),
                                          onPressed: () async {
                                            print('code notifications off');
                                            await FirebaseMessaging.instance.unsubscribeFromTopic("code");
                                          },
                                          //backgroundColor: Colors.green,
                                          child: Text('Unsubscribe', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textColor, fontFamily: 'CutiveMono')),
                                        )


                                      ]
                                  ),
                                ]
                            )
                        ),

                        OutlinedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(50.0, 1.0, 50.0, 1.0)),
                              backgroundColor: MaterialStateProperty.all<Color>(theme.backgroundColor),
                              side: MaterialStateProperty.all(BorderSide(color: theme.mainColor, width: 2))
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                          },
                          //backgroundColor: Colors.green,
                          child: Text('Sign Out', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textColor, fontFamily: 'CutiveMono')),
                        )

                      ]
                  )
              )
          )
      ),
      drawer: getDrawer(context),
    );
  }
}