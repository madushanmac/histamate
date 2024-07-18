import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/Components/Primary_button.dart';
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
              width: 400.0,
              decoration: BoxDecoration(
                  color: const Color(
                      0xffb86A789), // Or customize the background color
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
                  Text(user.email ?? ''),
                  // Text(
                  //   user.displayName ?? 'no name',
                  //   style: TextStyle(color: Colors.black),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            PrimaryButton(
                onTap: () {
                  Navigator.pop(context);
                },
                label: 'OK')
          ],
        ),
      ]),
    );
  }
}
