import 'package:be_real/Screens/followScreen.dart';
import 'package:be_real/Screens/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    getPostsusers() async {
  QueryDocumentSnapshot<Map<String, dynamic>>? user;
  QuerySnapshot<Map<String, dynamic>> UserData =
      await FirebaseFirestore.instance.collection('Users').get();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> userdataas = UserData.docs;
  return userdataas;
}

String? useridFollow;

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPostsusers(),
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
                    "Users",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  centerTitle: true,
                ),
                body: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: GestureDetector(
                        onTap: () async {
                          final prif = await SharedPreferences.getInstance();
                          
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(prif.getString('UidKey'))
                              .set({
                            'followers': [snapshot.data![index]['User Id']]
                          }, SetOptions(merge: true)).then((value) {});
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: Padding(
                                padding: EdgeInsets.all(08),
                                child: Text(
                                  'Follow',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data![index]['Profile Pic'])),
                      title: Text(
                        snapshot.data![index]['User name'],
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
