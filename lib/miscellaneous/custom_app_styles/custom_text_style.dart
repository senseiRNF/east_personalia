import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle title() {
    return const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle content() {
    return const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle comment() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
    );
  }
}