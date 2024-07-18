import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
        name: 'french-fries',
        iconPath: 'assets/images/foods/french-fries.png',
        boxColor: const Color(0xff767676)));

    categories.add(CategoryModel(
        name: 'vegetable ',
        iconPath: 'assets/images/foods/vegetable.png',
        boxColor: const Color(0xffd0d4d0)));

    categories.add(CategoryModel(
        name: 'hot-pot',
        iconPath: 'assets/images/foods/hot-pot.png',
        boxColor: const Color(0xff767676)));

    categories.add(CategoryModel(
        name: 'pizza',
        iconPath: 'assets/images/foods/pizza.png',
        boxColor: const Color(0xffd0d4d0)));
    categories.add(CategoryModel(
        name: 'mac',
        iconPath: 'assets/images/foods/pizza.png',
        boxColor: const Color(0xffd0d4d0)));

    return categories;
  }
}
