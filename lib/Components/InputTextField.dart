// ignore: file_names
import 'package:flutter/material.dart';

import '../styles/Styles.dart';

class InputTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;

  const InputTextField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        obscureText: obsecureText,
        controller: controller,
        style: const TextStyle(letterSpacing: 2.0),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintTextgreyLight,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: shadecoloer400),
            ),
            fillColor: shadecoloer200,
            filled: true),
      ),
    );
  }
}
