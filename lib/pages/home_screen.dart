import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/AI/ai_bot.dart';
import 'package:hista_mate/Components/Primary_button.dart';
import 'package:hista_mate/Components/SqureMenu.dart';
import 'package:hista_mate/pages/foods.dart';
import 'package:hista_mate/pages/login_screen.dart';
import 'package:hista_mate/pages/profile_details.dart';
import 'package:hista_mate/styles/Styles.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/scale_animation_transition.dart';
import 'package:page_animation_transition/animations/top_to_bottom_faded.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'calender_screen.dart';
import 'meal_recomondation.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteGrey,
        toolbarHeight: 70.0,
        leading: user.photoURL != null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL!),
          ),
        )
            : const Icon(Icons.account_circle, size: 40),
        title: Text(
          'Histamate',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              const Row(
                children: [
                  SizedBox(width: 25.0),
                  Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Foods()));
                    },
                    child: const SqureMenu(
                      title: 'Food Analyzer',
                      borderColor: Color(0xffb86A789),
                      backgroundColor: Color(0xffb86A789),
                      icon: Iconsax.activity, backgroudcolor: Color(0xffb86A789),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(
                          page: const MealRecommendation(),
                          pageAnimationType: FadeAnimationTransition()));
                    },
                    child: const SqureMenu(
                      title: 'Meal Planner',
                      borderColor: Color.fromARGB(249, 192, 208, 194),
                      backgroundColor: Color.fromARGB(249, 191, 206, 193),
                      icon: Iconsax.activity, backgroudcolor: Color.fromARGB(249, 191, 206, 193),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(
                          page: const CalendarScreen(),
                          pageAnimationType: ScaleAnimationTransition()));
                    },
                    child: const SqureMenu(
                      title: 'Symptoms Tracker',
                      borderColor: Color.fromARGB(249, 192, 208, 194),
                      backgroundColor: Color.fromARGB(249, 191, 206, 193),
                      icon: Iconsax.activity, backgroudcolor: Color.fromARGB(249, 191, 206, 193),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(
                          page: const Chat(
                            title: 'Histamate AI- Assistant',
                          ),
                          pageAnimationType: ScaleAnimationTransition()));
                    },
                    child: const SqureMenu(
                      title: 'AI\nChatbot',
                      borderColor: Color(0xffb86A789),
                      backgroundColor: Color(0xffb86A789),
                      icon: Iconsax.call, backgroudcolor: Color(0xffb86A789),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              PrimaryButton(
                onTap: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: Profile(),
                      pageAnimationType: TopToBottomFadedTransition()));
                },
                label: 'PROFILE',
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
