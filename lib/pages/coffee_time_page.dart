import 'package:flutter/material.dart';

class CoffeeTime extends StatefulWidget {
  @override
  _CoffeeTime createState() => _CoffeeTime();
}

class _CoffeeTime extends State<CoffeeTime>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text ('View by Coffee Time'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(

          ), 
          child: Column(
            children: [
              Row(
                children: [
                  // DropdownButton(items: items, onChanged: onChanged),
                  // DropdownButton(items: items, onChanged: onChanged),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}