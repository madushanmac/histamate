import 'package:flutter/material.dart';

class InfoModel {
  String name;
  String iconPath;
  String discription;
  Color boxColor;
  bool viewIsSelected;

  InfoModel({
    required this.name,
    required this.iconPath,
    required this.discription,
    required this.boxColor,
    required this.viewIsSelected
  });

  static List < InfoModel > getInfo() {
    List < InfoModel > info = [];

    info.add(
        InfoModel(
            name: 'french-fries',
            iconPath: 'assets/images/foods/french-fries.png',

            discription: 'this is description',

            viewIsSelected: true,
            boxColor: const Color(0xff4c5762)
        )
    );
    info.add(
        InfoModel(
            name: 'vegetable',
            iconPath: 'assets/images/foods/vegetable.png',

            discription: 'this is  description 2 ',

            viewIsSelected: true,
            boxColor: const Color(0xffd0d4d0)
        ),
    );
    info.add(
      InfoModel(
          name: 'vegetable',
          iconPath: 'assets/images/foods/hot-pot.png',

          discription: 'this is  description 2 ',

          viewIsSelected: true,
          boxColor: const Color(0xffd0d4d0)
      ),
    );

    return info;
  }
}