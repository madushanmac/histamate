import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/pages/login_screen.dart';
import '../Components/InputTextField.dart';
import '../Components/Primary_button.dart';
import '../Components/SqureTile.dart';
import '../styles/Styles.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _emailController = TextEditingController();

  // Dispose controller
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Method to send password reset email
  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Password reset link sent! Check your email.'),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('May I please have your email address?.'),
        ),
      );
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
            const SizedBox(height: 50.0),
            Center(
              child: Image.asset(
                'assets/images/splash.png',
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                'we will email you instructions \n to reset the password',
                style: welcometextStyle,
              ),
            ),
            const SizedBox(height: height),

            // Email input field
            InputTextField(
              hintText: 'Email',
              obsecureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: height25),

            // Reset Password button
            PrimaryButton(
              onTap: passwordReset,
              label: 'Reset Password',
            ),

            const SizedBox(height: height25),

            // Or continue with divider


            // Not a member? Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Login in',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
