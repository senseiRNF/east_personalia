import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration borderedTextField(String label) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black54,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      labelText: label,
    );
  }
}