import 'dart:io';

import 'package:be_real/Screens/LoginScreen.dart';
import 'package:be_real/Screens/homeScreen.dart';
import 'package:be_real/Screens/nameSceen.dart';
import 'package:be_real/Screens/profilePicScreen.dart';
import 'package:be_real/Widgets/appTittle.dart';
import 'package:be_real/Widgets/continueButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

TextEditingController signUpUsernameController = TextEditingController();
TextEditingController signUpEmailController = TextEditingController();
TextEditingController signUpPasswordController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomAppTittle(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter the code we send to +9876543210',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: signUpEmailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: signUpPasswordController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: signUpUsernameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'User name',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                    onTap: () async {
                      if (signUpEmailController.text == '' &&
                          signUpPasswordController.text == '' &&
                          signUpUsernameController.text == '') {
                        print('Enter values');
                      }else{
                         Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProfilePicScreen(
                          pass: signUpPasswordController.text,
                          email: signUpEmailController.text,
                          name: signUpUsernameController.text,
                        );
                      }));
                      }
                    },
                    child: ContinueButton(
                      txt: 'Continue',
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
