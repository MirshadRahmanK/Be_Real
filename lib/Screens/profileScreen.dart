import 'dart:io';

import 'package:be_real/Screens/settingsScreen.dart';
import 'package:be_real/Widgets/continueButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future<Map<String, dynamic>> getuserdetails() async {
  final prif = await SharedPreferences.getInstance();
  String? _uid = prif.getString('UidKey');
  QueryDocumentSnapshot<Map<String, dynamic>>? _user;
  QuerySnapshot<Map<String, dynamic>> _users =
      await FirebaseFirestore.instance.collection('Users').get();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> userdata = _users.docs;
  _user = userdata.firstWhere((element) => element['User Id'] == _uid);

  return _user.data();
}

Future<List<QueryDocumentSnapshot<Object?>>> getposts() async {
  List<QueryDocumentSnapshot> postdataas = [];
  await FirebaseFirestore.instance.collection('Post').get().then((value) {
    postdataas = value.docs;
  });
  return postdataas;
}

getFilefrmPhone() async {
  final pref = await SharedPreferences.getInstance();
  String uidss = pref.getString('UidKey').toString();
  String profilePicKey = pref.getString('profilepicKey').toString();
  String usernameKey = pref.getString('UsernameKey').toString();
  final filePicker = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  final filepath = filePicker!.files.single.path;
  final filename = filePicker.files.single.name;
  final images = await FirebaseStorage.instance
      .ref()
      .child('Images/$filename')
      .putFile(File(filepath!));
  String imageUrl = await images.ref.getDownloadURL();
  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>$imageUrl");
  FirebaseFirestore.instance.collection('Post').doc(uidss).set({
    'Image': imageUrl,
    'User Id': uidss,
  });
    // FirebaseFirestore.instance.collection('Users').doc(uidss).set({
    // 'Posts':imageUrl,
    // });
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SettingsScreen(
                      fun: getuserdetails(),
                    );
                  })),
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ))
        ],
      ),
      body: FutureBuilder(
          future: getuserdetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image(
                                image:
                                    NetworkImage(snapshot.data!['Profile Pic']),
                                fit: BoxFit.cover,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data!['User name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            snapshot.data!['User name'],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Memories",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.grey,
                            size: 15,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Only visible to you",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          getFilefrmPhone();
                        },
                        child: ContinueButton(txt: 'Upload Files')),
                  ),
                  // Expanded(
                  //   child: GridView.count(
                  //       crossAxisCount: 3,
                  //       crossAxisSpacing: 4.0,
                  //       mainAxisSpacing: 8.0,
                  //       children: [
                  //        Image(
                  //         height: 100,
                  //         width: 100,
                  //         image: NetworkImage(snapshot.data![]))
                  //       ]),
                  // )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          }),
    );
  }
}
