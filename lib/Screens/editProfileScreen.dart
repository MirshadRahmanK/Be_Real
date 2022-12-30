import 'package:be_real/Screens/discoveryScreen.dart';
import 'package:be_real/Screens/profileScreen.dart';
import 'package:be_real/Widgets/continueButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen();

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

TextEditingController editnameController = TextEditingController();

Future<Map<String, dynamic>> getuserdetailsedit() async {
  final prif = await SharedPreferences.getInstance();
  String? _uid = prif.getString('UidKey');
  QueryDocumentSnapshot<Map<String, dynamic>>? _user;
  QuerySnapshot<Map<String, dynamic>> _users =
      await FirebaseFirestore.instance.collection('Users').get();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> userdata = _users.docs;
  _user = userdata.firstWhere((element) => element['User Id'] == _uid);
  editnameController.text = _user.data()['User name'];

  return _user.data();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
       
      ),
      body: FutureBuilder(
          future: getuserdetailsedit(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: editnameController,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                      onTap: () async {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(snapshot.data!['User name'])
                            .update({'User name': editnameController.text});
                      },
                      child: ContinueButton(txt: 'Save'))
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
          }),
    );
  }
}
