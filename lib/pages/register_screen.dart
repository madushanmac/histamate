import 'package:flutter/material.dart';
import 'package:hista_mate/pages/food_analysis.dart';

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
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  // sign in method
  void signUserIn() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FoodAnalysis()));
    // Show a dialog with a circular progress indicator
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) {
    //     return Center(
    //       child: Container(
    //           height: 120.0,
    //           width: 120.0,
    //           padding: const EdgeInsets.all(20.0),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(8), color: Colors.white),
    //           child: const Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text('please wait'),
    //               CircularProgressIndicator(
    //                 color: Colors.black,
    //               ),
    //             ],
    //           )),
    //     );
    //   },
    // );

    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: usernameController.text, password: passwordController.text);
    // } on FirebaseAuthException catch (e){
    //   // Show an AlertDialog with an error message if authentication fails
    //   await showGeneralDialog(
    //     context: context,
    //     pageBuilder: (context, _, __) {
    //       return AlertDialog(
    //         title: const Text('Authentication Error'),
    //         content: Text(_getErrorText(e.code)),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    // Close the progress dialog
    // Navigator.of(context).pop(); // comments this because without fill the username and password dialog ok btn will act as normally
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
              hintText: 'password',
              obsecureText: true,
              controller: passwordController,
            ),
            InputTextField(
              hintText: 're-enter password',
              obsecureText: true,
              controller: repasswordController,
            ),

            // Forgot password
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Forget password?."),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0))
              ],
            ),
            const SizedBox(
              height: height25,
            ),

            // Sign in button
            PrimaryButton(
              onTap: signUserIn,
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

            // Not a member? Register now
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
                const Text(
                  'Login now',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
