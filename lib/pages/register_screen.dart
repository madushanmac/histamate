import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/pages/login_screen.dart';

import '../Components/InputTextField.dart';
import '../Components/Primary_button.dart';
import '../Components/SqureTile.dart';
import '../styles/Styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  // Sign up method
  void signUserUp() async {
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
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);

      final user = FirebaseAuth.instance.currentUser;
      await user!.updateDisplayName(usernameController.text);
      await user.reload();

      Navigator.of(context).pop(); // Close the progress dialog

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } on FirebaseAuthException catch (e) {
      // Show an AlertDialog with an error message if authentication fails
      Navigator.of(context).pop(); // Close the progress dialog
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Authentication Error'),
            content: Text(_getErrorText(e.code)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  String _getErrorText(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'The email address is already in use.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An undefined Error happened.';
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
              ),
            ),
            Text(
              'Register with Hista mate \nsget your helthy recomondation today',
              style: boldtext,
            ),
            const SizedBox(
              height: height,
            ),

            // Username and Password fields
            InputTextField(
              hintText: 'username',
              obsecureText: false,
              controller: usernameController,
            ),
            InputTextField(
              hintText: 'email',
              obsecureText: false,
              controller: emailcontroller,
            ),
            InputTextField(
              hintText: 'password',
              obsecureText: true,
              controller: passwordcontroller,
            ),


            const SizedBox(
              height: height25,
            ),

            // Sign up button
            PrimaryButton(
              onTap: signUserUp,
              label: 'Sign up',
            ),

            // Or continue with divider
            const SizedBox(
              height: height25,
            ),
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                      thickness: 2.5,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Or Sign up with'),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                      thickness: 2.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: height25,
            ),

            // Google and Apple sign-in options
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SqureTile(imagePath: 'assets/images/logos/google.png'),
                SizedBox(
                  width: 25.0,
                ),
                SqureTile(imagePath: 'assets/images/logos/apple-logo.png'),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),

            // Already have an account? Login now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account ?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Login now',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
