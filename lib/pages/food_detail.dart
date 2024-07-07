import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hista_mate/pages/home_screen.dart';
import 'package:page_animation_transition/animations/scale_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';


class FoodDetail extends StatelessWidget {
  const FoodDetail({super.key, required this.title, required this.imagePath, required this.description});

  final String title;
  final String imagePath;
  final String description;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: const Text(
          'FOOD DETAIL ',
          style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
          backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () async {
            //exitApp(context);
            //await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              'assets/icons/back.png',
              height: 25,
              width: 25,
            ),
          ),
        ),
          centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              Navigator.of(context).push(PageAnimationTransition(
                  page:  HomeScreen(),
                  pageAnimationType: ScaleAnimationTransition()));
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                  color: const Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/icons/application.png',
                height: 25,
                width: 25,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(imagePath),
          ),
          Container(
            height: 200.0,
            padding: const EdgeInsets.only(top: 10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                colors: [Colors.black54,Colors.white38],
                begin: Alignment.topCenter,end: Alignment.bottomCenter
              )
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Text(title ,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,letterSpacing: 2.0),),
              ),
              const Divider(thickness: 2.0,height: 2,color: Colors.black54,indent: 20,endIndent: 20,),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Text(description,style: GoogleFonts.acme(textStyle: TextStyle(fontSize: 18)),),
              )
            ],
          )),

        ],
      ),
    );
  }
}
