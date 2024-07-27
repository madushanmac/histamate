
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/pages/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  // addMeal('Weight Loss', 'Vegetarian', 'sample salsad');
  // addMeal('Muscle Gain', 'Vegan', 'Vegan Protein Shake sample');
  // addMeal('Maintenance', 'Keto', 'Keto Smoothie sample');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'HistaMate',
      theme: ThemeData(
        primaryColor: Colors.green,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
 // check circuler progress indicator not pop down

void addMeal(String goal, String preference, String mealName) async {
  await FirebaseFirestore.instance.collection('meals').add({
    'goal': goal,
    'preference': preference,
    'mealName': mealName,
  });
}
