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
      appBar: AppBar(
        title: const Text(
          'FOOD DETAIL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/icons/back.png',
              height: 25,
              width: 25,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).push(PageAnimationTransition(
          //         page: HomeScreen(),
          //         pageAnimationType: ScaleAnimationTransition()));
          //   },
          //   child: Container(
          //     margin: const EdgeInsets.all(10),
          //     alignment: Alignment.center,
          //     width: 37,
          //     decoration: BoxDecoration(
          //       color: const Color(0xffF7F8F8),
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Image.asset(
          //       'assets/icons/application.png',
          //       height: 25,
          //       width: 25,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(imagePath),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const Divider(
                  thickness: 2.0,
                  height: 20,
                  color: Colors.black54,
                ),
                const SizedBox(height: 20.0),
                Text(
                  description,
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(fontSize: 18),
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
