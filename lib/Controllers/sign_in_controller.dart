import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Utils/custom_snack_bar.dart';
import 'package:notes_app/Views/Home-Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  final formkeySignIn = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  Future signIn(BuildContext context) async {
    if (formkeySignIn.currentState!.validate()) {
      // Perform sign-in logic here
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      try {
        isLoading.value = true;
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('uid', userCredential.user!.uid);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);

        isLoading.value = false;
        CustomSnackBar.showSuccess(
            message: 'Sign in successful', context: context);

        emailController.clear();
        passwordController.clear();
      } catch (e) {
        isLoading.value = false;
        print("Error during sign in: $e");
        CustomSnackBar.showError(
            message: '${e.toString().split(']')[1].trim()}', context: context);
      }
    }
  }
}
