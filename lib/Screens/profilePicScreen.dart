import 'dart:io';

import 'package:be_real/Screens/homeScreen.dart';
import 'package:be_real/Widgets/appTittle.dart';
import 'package:be_real/Widgets/continueButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicScreen extends StatefulWidget {
  String name;
  String email;
  String pass;
  ProfilePicScreen(
      {required this.email, required this.name, required this.pass});

  @override
  State<ProfilePicScreen> createState() => _ProfilePicScreenState();
}

String? profilePicname;
String? profilePicPath;
String? pofilePicUrl;
getProfilePic() async {
  final filePicker = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  profilePicname = filePicker!.files.single.name;
  profilePicPath = filePicker.files.single.path;
}

class _ProfilePicScreenState extends State<ProfilePicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
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
              child: GestureDetector(
                onTap: () async {
                  getProfilePic();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'By tapping \"Continue\", you agree to our',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Privacy Policy ',
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold),
                ),
                Text(
                  'and ',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Terms of Service.',
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
                onTap: () async {
                  final prif = await SharedPreferences.getInstance();
                  final signUp = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: widget.email, password: widget.pass);

                  final sendProfile = await FirebaseStorage.instance
                      .ref()
                      .child('Profile Pic/$profilePicname')
                      .putFile(File(profilePicPath!));

                  pofilePicUrl = await sendProfile.ref.getDownloadURL();
                  await prif.setString('UidKey', signUp.user!.uid);
                  await prif.setString('UsernameKey', widget.name);
                  await prif.setString('profilepicKey', pofilePicUrl!);
                  String? uidKy = prif.getString('UidKey');
                  FirebaseFirestore.instance.collection('Users').doc(uidKy).set({
                    'Email': widget.email,
                    'User name': widget.name,
                    'Profile Pic': pofilePicUrl,
                    'User Id': signUp.user!.uid,
                    'followers':[],
                  });
                  
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
                child: ContinueButton(
                  txt: 'Continue',
                )),
          ],
        ),
      ),
    );
  }
}
