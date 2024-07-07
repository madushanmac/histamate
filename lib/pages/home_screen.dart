import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/AI/ai_bot.dart';
import 'package:hista_mate/Components/Primary_button.dart';
import 'package:hista_mate/Components/SqureMenu.dart';

import 'package:hista_mate/pages/foods.dart';
import 'package:hista_mate/pages/profile_details.dart';
import 'package:hista_mate/styles/Styles.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/scale_animation_transition.dart';
import 'package:page_animation_transition/animations/top_to_bottom_faded.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import 'calender_screen.dart';

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
          // user.email ?? 'No Email',
          'Histamate',

          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Row(
            children: [
              SizedBox(
                width: 25.0,
              ),
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Foods()));
                      },
                      child: const SqureMenu(
                        title: 'Food Analyzer',
                        // ignore: use_full_hex_values_for_flutter_colors
                        borderColor: Color(0xffb86A789),
                        // ignore: use_full_hex_values_for_flutter_colors
                        backgroudcolor: Color(0xffb86A789),
                        icon: Iconsax.activity,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageAnimationTransition(
                            page: const CalendarScreen(),
                            pageAnimationType: FadeAnimationTransition()));
                      },
                      child: const SqureMenu(
                        title: 'Meal Planner',
                        borderColor: Color.fromARGB(249, 192, 208, 194),
                        backgroudcolor: Color.fromARGB(249, 191, 206, 193),
                        icon: Iconsax.activity,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageAnimationTransition(
                            page: const CalendarScreen(),
                            pageAnimationType: ScaleAnimationTransition()));
                      },
                      child: const SqureMenu(
                        title: 'Symptoms Tracker',
                        borderColor: Color.fromARGB(249, 192, 208, 194),
                        backgroudcolor: Color.fromARGB(249, 191, 206, 193),
                        icon: Iconsax.activity,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageAnimationTransition(
                            page: const Chat(
                              title: 'Histamate AI- Assistent',
                            ),
                            pageAnimationType: ScaleAnimationTransition()));
                      },
                      child: const SqureMenu(
                        title: 'AI\nChatbot',
                        // ignore: use_full_hex_values_for_flutter_colors
                        borderColor: Color(0xffb86a789),
                        // ignore: use_full_hex_values_for_flutter_colors
                        backgroudcolor: Color(0xffb86A789),
                        icon: Iconsax.call,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          PrimaryButton(
              onTap: () {
                Navigator.of(context).push(PageAnimationTransition(
                    page: Profile(),
                    pageAnimationType: TopToBottomFadedTransition()));
              },
              label: 'PROFILE'),
          const SizedBox(
            height: 10.0,
          ),
          // PrimaryButton(
          //     onTap: () async {
          //       await FirebaseAuth.instance.signOut();
          //     },
          //     label: 'LOGOUT'),
        ],
      ),
    );
  }
}


//Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: BottomToTopTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: TopToBottomTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: RightToLeftTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: LeftToRightTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: FadeAnimationTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: ScaleAnimationTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: RotationAnimationTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: TopToBottomFadedTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: BottomToTopFadedTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: RightToLeftFadedTransition()));
//
// Navigator.of(context).push(PageAnimationTransition(page: const PageTwo(), pageAnimationType: LeftToRightFadedTransition()));