import 'package:flutter/material.dart';
import '../../main.dart';
import '../../utils/video_player.dart';

class BrewingCoffee extends StatelessWidget {
  const BrewingCoffee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brewing Coffee",
            textAlign: TextAlign.center,
            style: TextStyle(color: theme.textColor)),
        backgroundColor: theme.barColor,
        iconTheme: IconThemeData(color: theme.textColor),
        centerTitle: true,
      ),
      body: Column(
        children: [
          VideoPlayer(collectionPath: 'brewing coffee'),
        ],
      ),
    );
  }
}