import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart" show Firebase;

import './Pages/signIn/signin.dart';
import './Pages/Home/add_word.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Check if the user is already signed in
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(user: user));
}
class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({required this.user, super.key, Key});

  @override
  Widget build(BuildContext context) {
    // Conditional navigation based on the user's sign-in status
    if (user == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false, // Set to false to remove the debug banner
        title: 'Izhiman Dictionary',
        theme: ThemeData(primarySwatch: Colors.red ,
            primaryColor: Colors.redAccent),
        home: SignInPage(), // Navigate to Sign In page if user is null
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false, // Set to false to remove the debug banner
        title: 'Izhiman Dictionary',
        theme: ThemeData(primarySwatch: Colors.cyan,
        primaryColor: Colors.deepOrange, bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white60)),
        home: const MyHomePage(title: 'Home Page'), // Navigate to main page if user is not null
      );
    }
  }
}
