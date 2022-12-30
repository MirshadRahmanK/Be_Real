import 'package:be_real/Screens/LoginScreen.dart';
import 'package:be_real/Screens/editProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  Future fun;
  SettingsScreen({required this.fun});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: FutureBuilder(
            future: widget.fun,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: GestureDetector(
                          onTap: () async {
                            final prif = await SharedPreferences.getInstance();
                            String? _uid = prif.getString('UidKey');
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return EditProfileScreen();
                            }));
                          },
                          child: ListTile(
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Colors.grey,
                                )),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data!['Profile Pic']),
                            ),
                            subtitle: Text(
                              snapshot.data!['User name'],
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            title: Text(
                              snapshot.data['User name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'ABOUT',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.grey,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.ios_share,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Share BeReal",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.star_border,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Rate BeReal",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Help",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.details,
                        color: Colors.white,
                      ),
                      title: Text(
                        "About",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }), (route) => false);
                            },
                            child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  "Log Out",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
            }),
      ),
    );
  }
}
