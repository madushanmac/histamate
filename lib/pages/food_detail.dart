import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetail extends StatelessWidget {
  const FoodDetail({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  final String title;
  final String imagePath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Meal info'),
        backgroundColor: Color(0xFFE1F1D8),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,

            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,style: TextStyle(fontSize: 25.0),
                  ),

                const Divider(
                  thickness: 1.0,
                  height: 20,
                  color: Colors.black26,
                ),
                const SizedBox(height: 20.0),
                Text(
                  description,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
