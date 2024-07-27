import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hista_mate/styles/Styles.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteGrey,
        title: const Text(
          'User Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 100.0,
      ),
      body: ListView(children: [
        Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Container(
              width: 350.0,
              decoration: BoxDecoration(
                  color: const Color(
                      0xFFE1F1D8), // Or customize the background color
                  borderRadius: BorderRadius.circular(10.0)),
              height: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                children: [
                  // Display a placeholder or default icon if no photoURL is available
                  user.photoURL != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL!),
                        )
                      : const Icon(
                          Icons.account_circle, // Use a generic account icon
                          size: 100, // Adjust size as needed
                        ),
                  const SizedBox(
                      height: 16), // Add spacing between icon and text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text('Email : '),
                      Text(user.email ?? ''),

                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text('User name : '),
                      Text(
                        user.displayName ?? 'your name is not included',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),

          ],
        ),
      ]),
    );
  }
}
