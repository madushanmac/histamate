import 'package:flutter/material.dart';

class SqureMenu extends StatelessWidget {
  const SqureMenu(
      {super.key,
      required this.title,
      required this.borderColor,

      required this.icon, required Color backgroundColor, required this.backgroudcolor});

  final String title;
  final Color borderColor, backgroudcolor;
  final IconData icon;

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
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
            Icon(icon,size: 60,)
          ],
        )));
  }
}
