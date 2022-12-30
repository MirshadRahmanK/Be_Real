import 'package:be_real/Screens/dateOfBirthScreen.dart';
import 'package:be_real/Screens/profilePicScreen.dart';
import 'package:be_real/Widgets/appTittle.dart';
import 'package:be_real/Widgets/continueButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

TextEditingController nameController = TextEditingController();

class _NameScreenState extends State<NameScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomAppTittle(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Let's get started, what's your name?",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Your name',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () async {
                  FirebaseFirestore.instance
                      .collection('Users')
                      .add({'Name': nameController.text});
                },
                child: ContinueButton(txt: 'Continue'),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
