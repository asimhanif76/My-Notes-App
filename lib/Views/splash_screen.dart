import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Views/Home-Screens/home_screen.dart';
import 'package:notes_app/Views/SignIn-SignUp-Screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(Duration(seconds: 2)); // splash delay
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false,);
    } else {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => SignInScreen()),(route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_logo.png', height: 80),
            SizedBox(height: 20),
            Text(
              "My Notes",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade300,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Organize your thoughts",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
