import 'package:flutter/material.dart';
import '../../utils/video_player.dart';

class BrewingCoffee extends StatelessWidget {
  const BrewingCoffee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brewing Coffee",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.black,
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