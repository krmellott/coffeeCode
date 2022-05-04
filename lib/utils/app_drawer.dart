///Creates the drawer that allows users to navigate through the app.
///Yes, this is just a Drawer object and a method that gets it.
///@author Spencer Leisch

import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/coffee_coffee_page.dart';
import '../pages/coffee_journal_page.dart';
import '../pages/coffee_time_page.dart';
import '../pages/settings_page.dart';
import '../pages/videos_page.dart';

Drawer coffeeTimeDrawer = const Drawer();

Drawer getDrawer(BuildContext context) {
  return coffeeTimeDrawer = Drawer(
      backgroundColor: theme.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Image.asset('assets/BC_CoffeeLogo.png')),
          ListTile(
              title: Text("Coffee Type", style: TextStyle(color: theme.textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return CoffeePage();
                }));
              }
          ),
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
                  return const MainJournal();
                }));
              }
          ),
          ListTile(
              title: Text("Settings", style: TextStyle(color: theme.textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return const SettingsPage();
                }));
              }
          )
        ],
      )
  );
}
