import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/Components/Primary_button.dart';
import 'package:hista_mate/Components/SqureMenu.dart';
import 'package:hista_mate/pages/foods.dart';
import 'package:hista_mate/pages/login_screen.dart';
import 'package:hista_mate/pages/ownership_label.dart';
import 'package:hista_mate/pages/profile_details.dart';
import 'package:hista_mate/styles/Styles.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: whiteGrey,
        toolbarHeight: 70.0,
        title: Text(
          'HistaMate',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool? shouldSignOut = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Sign Out'),
                    content: Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(
                              false); // Dismiss the dialog and return false
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(true); // Dismiss the dialog and return true
                        },
                        child: Text('Sign Out'),
                      ),
                    ],
                  );
                },
              );

              if (shouldSignOut == true) {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: OwnershipLabel(
        ownerName: 'Assign Pro ',
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                const Row(
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                        Navigator.of(context).push(PageAnimationTransition(
                            page: const Foods(),
                            pageAnimationType: FadeAnimationTransition()));
                      },
                      child: const SqureMenu(
                          title: 'Food Analyzer',
                          borderColor: Color(0xffb86A789),
                          iconUrl: 'assets/icons/burger.png'),
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
                        iconUrl: 'assets/icons/dinner.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageAnimationTransition(
                            page: const CalendarScreen(),
                            pageAnimationType: FadeAnimationTransition()));
                      },
                      child: const SqureMenu(
                        title: 'Daily Log',
                        borderColor: Color.fromARGB(249, 192, 208, 194),
                        iconUrl: 'assets/icons/calendar.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(PageAnimationTransition(
                        //     page: const Chat(
                        //       title: 'Histamate AI- Assistant',
                        //     ),
                        //     pageAnimationType: ScaleAnimationTransition()));
                      },
                      child: const SqureMenu(
                        title: 'AI Assistant',
                        borderColor: Color(0xffb86A789),
                        iconUrl: 'assets/icons/bot.png',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                PrimaryButton(
                  onTap: () {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: Profile(),
                        pageAnimationType: FadeAnimationTransition()));
                  },
                  label: 'My Profile',
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
