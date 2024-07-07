import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoModel {
  String name;
  String iconPath;
  String description;
  Color boxColor;
  bool viewIsSelected;

  InfoModel({
    required this.name,
    required this.iconPath,
    required this.description,
    required this.boxColor,
    required this.viewIsSelected,
  });

  static InfoModel fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return InfoModel(
      name: data['title'] ?? '',
      iconPath: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      boxColor: Color(int.parse(data['boxColor'] ?? '0xff4c9762')),
      viewIsSelected: data['viewIsSelected'] ?? false,
    );
  }

  static Future<List<InfoModel>> getInfo() async {
    List<InfoModel> infoList = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('recomondations').get();
      for (var doc in querySnapshot.docs) {
        infoList.add(InfoModel.fromFirestore(doc));
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return infoList;
  }
}
