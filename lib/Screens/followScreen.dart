import 'dart:ui';

import 'package:be_real/Screens/discoveryScreen.dart';
import 'package:be_real/Widgets/continueButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowScreen extends StatefulWidget {
  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

Future<Map<String, dynamic>> userFollow() async {
  final prif = await SharedPreferences.getInstance();
  String? _uid = prif.getString('UidKey');
  QueryDocumentSnapshot<Map<String, dynamic>>? _user;
  QuerySnapshot<Map<String, dynamic>> _users =
      await FirebaseFirestore.instance.collection('Users').get();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> userdata = _users.docs;
  _user = userdata.firstWhere((element) => element['User Id'] == _uid);

  return _user.data();
}

class _FollowScreenState extends State<FollowScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userFollow(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                  snapshot.data!['User name'],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        image: NetworkImage(snapshot.data!['Profile Pic']),
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!['User name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "I don't understand this app",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {}, child: ContinueButton(txt: 'Add')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add your real friend on be real",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
