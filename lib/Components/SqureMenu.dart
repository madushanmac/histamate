import 'package:flutter/material.dart';

class SqureMenu extends StatelessWidget {
  const SqureMenu(
      {super.key,
      required this.title,
      required this.borderColor,

     required this.iconUrl});

  final String title,iconUrl;
  final Color borderColor;
  

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.0,
        width: 150.0,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(

            border: Border.all(color: borderColor,width: 3),
            borderRadius: BorderRadius.circular(10),
            ),
        child: Center(
            child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
            Image.asset(iconUrl,width: 75,height: 75,)
          ],
        )));
  }
}
