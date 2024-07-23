import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/pages/home_screen.dart';
import 'package:hista_mate/pages/passwordReset.dart';
import 'package:hista_mate/pages/register_screen.dart';

import '../Components/InputTextField.dart';
import '../Components/Primary_button.dart';
import '../styles/Styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in method
  void signUserIn() async {
    // Show a dialog with a circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
              height: 120.0,
              width: 120.0,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ],
              )),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      // Close the progress dialog
      Navigator.of(context).pop();
      // Navigate to HomeScreen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      // Close the progress dialog
      Navigator.of(context).pop();
      // Show an AlertDialog with an error message if authentication fails
      await showGeneralDialog(
        context: context,
        pageBuilder: (context, _, __) {
          return AlertDialog(
            title: const Text('Authentication Failed'),
            content: Text(_getErrorText(e.code)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Method to get error message based on error code
  String _getErrorText(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'Invalid email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'user-disabled':
        return 'User account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteGrey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo and welcome message
            const SizedBox(
              height: 50.0,
            ),
            Center(
                child: Image.asset(
                  'assets/images/splash.png',
                  height: 100,
                  width: 100,
                )),
            Text(
              textAlign: TextAlign.center,
              'Welcome back you HistaMate! \n Log in',
              style: welcometextStyle,
            ),
            const SizedBox(
              height: height,
            ),

            // Username and Password fields
            InputTextField(
              hintText: 'Email',
              obsecureText: false,
              controller: usernameController,
            ),
            InputTextField(
              hintText: 'Password',
              obsecureText: true,
              controller: passwordController,
            ),

            // Forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordReset()));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0))
              ],
            ),
            const SizedBox(
              height: height25,
            ),

            // Sign in button
            PrimaryButton(
              onTap: signUserIn,
              label: 'Login',
            ),

            // Or continue with divider
            const SizedBox(
              height: height25,
            ),


            // Not a member? Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
