import 'package:be_real/Screens/discoveryScreen.dart';
import 'package:be_real/Screens/myFriendsScreen.dart';
import 'package:be_real/Screens/profilePicScreen.dart';
import 'package:be_real/Screens/profileScreen.dart';
import 'package:be_real/Screens/usersListScreen.dart';
import 'package:be_real/Widgets/appTittle.dart';
import 'package:be_real/Widgets/continueButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? _profilePicurl;
String? userId;
// bool profileLoad = true;

class _HomeScreenState extends State<HomeScreen> {
  bool myFiendsBool = true;

  getIds() async {
    final prif = await SharedPreferences.getInstance();
    userId = prif.getString('UidKey');
    return userId;
  }

  Future<Map<String, dynamic>> getUsers() async {
    final prif = await SharedPreferences.getInstance();
    String? getUid = prif.getString('UidKey');
    QueryDocumentSnapshot<Map<String, dynamic>>? user;
    QuerySnapshot<Map<String, dynamic>> users =
        await FirebaseFirestore.instance.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> userdataas = users.docs;
    user =
        userdataas.firstWhere((element) => element.data()['User Id'] == getUid);
    return user.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return UsersListScreen();
              }));
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            )),
        title: CustomAppTittle(),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return ProfileScreen();
            })),
            child: FutureBuilder(
                future: getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data!['Profile Pic']),
                    );
                  } else {
                    return CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Center(
                          child: Icon(
                        Icons.person,
                        color: Colors.black,
                      )),
                    );
                  }
                }),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      myFiendsBool = true;
                    });
                  },
                  child: Text(
                    'My Friends',
                    style: TextStyle(
                        color: myFiendsBool ? Colors.white : Colors.grey),
                  )),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {
                    getIds();
                    setState(() {
                      myFiendsBool = false;
                    });
                  },
                  child: Text(
                    'Discovery',
                    style: TextStyle(
                        color: myFiendsBool ? Colors.grey : Colors.white),
                  )),
            ],
          ),
          myFiendsBool
              ? MyFriendsScreen()
              : DiscoveryScreen(
                  useriD: userId!,
                )
        ],
      ),
    );
  }
}
