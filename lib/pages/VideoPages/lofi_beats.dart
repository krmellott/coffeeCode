import 'package:flutter/material.dart';
import '../../utils/video_player.dart';

class LofiBeats extends StatelessWidget {
  const LofiBeats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lofi Beats",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          VideoPlayer(collectionPath: 'lofi beats'),
        ],
      ),
    );
  }
}