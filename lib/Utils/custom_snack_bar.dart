import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required String message,
    required BuildContext context,
    Color backgroundColor = const Color(0xFF323232),
    Color textColor = Colors.white,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static void showError({
    required String message,
    required BuildContext context,
  }) {
    show(
      message: message,
      context: context,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
  static void showSuccess({
    required String message,
    required BuildContext context,
  }) {
    show(
      message: message,
      context: context,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
  
}