import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/Views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDzKMxm2bEhXQo4JhvXuIGMfPD54eewg8c",
          authDomain: "my-notes-ab209.firebaseapp.com",
          projectId: "my-notes-ab209",
          storageBucket: "my-notes-ab209.firebasestorage.app",
          messagingSenderId: "778559149812",
          appId: "1:778559149812:web:827b757e4d48c0791230a1",
          measurementId: "G-Z5RC7MKLS1"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
