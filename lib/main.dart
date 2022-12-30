import 'package:be_real/Screens/LoginScreen.dart';
import 'package:be_real/Screens/nameScreen.dart';
import 'package:be_real/Screens/dateOfBirthScreen.dart';
import 'package:be_real/Screens/homeScreen.dart';
import 'package:be_real/Screens/nameSceen.dart';
import 'package:be_real/Screens/profilePicScreen.dart';
import 'package:be_real/Screens/profileScreen.dart';
import 'package:be_real/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      home: StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return HomeScreen();
      } else {
        return LoginScreen();
      }
    },
  )));
}
