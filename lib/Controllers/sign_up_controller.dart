import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Models/user_model.dart';
import 'package:notes_app/Utils/custom_snack_bar.dart';
import 'package:notes_app/Views/Home-Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  final formkeySignUp = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isLoading = false.obs;

  Future signUp(BuildContext context) async {
    if (formkeySignUp.currentState!.validate()) {
      // Perform sign-up logic here
      String name = nameController.text.trim();
      String userName = userNameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      try {
        if (password != confirmPassword) {
          CustomSnackBar.showError(
              message: 'Password do not match!', context: context);
          return;
        }
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String userId = userCredential.user!.uid;

        if (userCredential != null) {
          final user = UserModel(
              name: name, userName: userName, email: email, uid: userId);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set(user.toJson());

          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('uid', userId);

          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);

          CustomSnackBar.showSuccess(
              message: 'Sign up successful', context: context);

          nameController.clear();
          userNameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        } else {
          CustomSnackBar.showError(message: 'Sign up failed', context: context);
        }
      } catch (e) {
        isLoading.value = false;
        print("Error during sign up: $e");
        CustomSnackBar.showError(
            message: '${e.toString().split(']')[1].trim()}', context: context);
      }
    }
  }
}
