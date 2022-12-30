import 'dart:io';
import 'dart:ui';

import 'package:be_real/Screens/homeScreen.dart';
import 'package:be_real/Screens/profileScreen.dart';
import 'package:be_real/Widgets/continueButton.dart';
import 'package:be_real/Widgets/postCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFriendsScreen extends StatefulWidget {
  @override
  State<MyFriendsScreen> createState() => _MyFriendsScreenState();
}

class _MyFriendsScreenState extends State<MyFriendsScreen> {
  getFile() async {
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
    FirebaseFirestore.instance.collection('Users').doc(uidss).set({
      'Posts': imageUrl,
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getPostsfrmFollowers() async {
    QueryDocumentSnapshot<Map<String, dynamic>>? user;
    final prif = await SharedPreferences.getInstance();
    DocumentSnapshot<Map<String, dynamic>> UserData = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(prif.getString('UidKey'))
        .get();
    final followpostes =
        await FirebaseFirestore.instance.collection('Post').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> fileteredPosts =
        followpostes.docs.where((element) {
      return (UserData.data()!['followers'] as List)
          .any((e) => e == element.id);
    }).toList();
    print(
        '22222222222222222222222222222${fileteredPosts.first.data()['Image']}');
    // return UserData.data()!['followers'];
    return fileteredPosts;
  }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getFollowersPosts(uidss) {
  //   final followpostes =
  //       FirebaseFirestore.instance.collection('Post').doc(uidss).get();
  //   print(followpostes);
  //   return followpostes;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: getPostsfrmFollowers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PostCard(
                    name: 'qw',
                    place: 'place',
                    hrs: 'hrs',
                    profile:
                        'https://firebasestorage.googleapis.com/v0/b/bereal-c2fcd.appspot.com/o/Profile%20Pic%2Fdownload.jpeg?alt=media&token=6a7086d5-023f-4f4e-a28e-98b824bed674',
                    imageUrl: snapshot.data![index]['Image']);
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
