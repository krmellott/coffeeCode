import 'package:flutter/material.dart';

import '../main.dart';

class ImageButton extends StatelessWidget {
  final String label;
  final String image;
  final Function() onTap;
  const ImageButton(
      {Key? key, required this.label, required this.onTap, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        color: theme.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          // alignment: Alignment.center,
            children: <Widget>[
              Ink.image(
                image: NetworkImage(image),
                height: 250,
                width: 185,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: onTap,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: theme.textColor,
                ),
              )
            ]),
      ),
    );
  }
}