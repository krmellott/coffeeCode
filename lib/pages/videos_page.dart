import 'package:flutter/material.dart';
import 'package:the_coffee_and_code/pages/VideoPages/brewing_coffee.dart';
import 'package:the_coffee_and_code/pages/VideoPages/favorite_video.dart';
import 'package:the_coffee_and_code/pages/VideoPages/lofi_beats.dart';
import 'package:the_coffee_and_code/pages/settings_page.dart';

import '../main.dart';
import '../utils/image.dart';
import '../utils/image_buttons.dart';
import 'VideoPages/coding_tutorial.dart';
import 'VideoPages/coffee_recipe.dart';
import 'coffee_journal_page.dart';
import 'coffee_time_page.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos", textAlign: TextAlign.center, style: TextStyle(color: theme.textColor),),
        backgroundColor: theme.barColor,
        iconTheme: IconThemeData(color: theme.textColor),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [theme.backgroundColor, theme.backgroundColor])),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageButton(
                      label: "Coding Tutorials",
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const CodingTutorial();
                          })),
                      image: Images.coding_tutorial_image),
                  ImageButton(
                      label: "Coffee Recipes",
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const CoffeeRecipe();
                          })),
                      image: Images.coffee_recipes_image),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageButton(
                      label: "Brewing Coffee",
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const BrewingCoffee();
                          })),
                      image: Images.brewing_coffee_image),
                  ImageButton(
                      label: "lofi",
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const LofiBeats();
                          })),
                      image: Images.lofi_image),
                ],
              ),
              Row(
                children: [
                  ImageButton(
                      label: "Favorite Videos",
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const FavoriteVideo();
                          })),
                      image: Images.favorites),
                ],
              ),
            ],
          ),
        ),
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
