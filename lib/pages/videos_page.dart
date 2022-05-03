import 'package:flutter/material.dart';
import 'package:the_coffee_and_code/pages/VideoPages/brewing_coffee.dart';
import 'package:the_coffee_and_code/pages/VideoPages/favorite_video.dart';
import 'package:the_coffee_and_code/pages/VideoPages/lofi_beats.dart';

import '../utils/image.dart';
import '../utils/image_buttons.dart';
import 'VideoPages/coding_tutorial.dart';
import 'VideoPages/coffee_recipe.dart';

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
        title: const Text("Videos", textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(225, 0, 255, 0)),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black])),
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
    );
  }

}
