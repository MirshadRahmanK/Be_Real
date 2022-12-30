import 'package:be_real/Widgets/postCard.dart';
import 'package:be_real/Widgets/subtitleTxt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Widgets/continueButton.dart';

class DiscoveryScreen extends StatefulWidget {
  String useriD;
  DiscoveryScreen({required this.useriD});
  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

String? postUid;

Future<List<QueryDocumentSnapshot>> getUsers() async {
  String? postuid;
  String? useruid;
  List<QueryDocumentSnapshot> postdataas = [];
  await FirebaseFirestore.instance.collection('Post').get().then((PostData) {
    postdataas = PostData.docs;
    // postUid = postdataas.elementAt(index)['User id'];
  });
  return postdataas;
}

Future<Map> getPosts(String uid) async {
  QueryDocumentSnapshot<Map<String, dynamic>>? user;
  QuerySnapshot<Map<String, dynamic>> UserData =
      await FirebaseFirestore.instance.collection('Users').get();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> userdataas = UserData.docs;
  user = userdataas.firstWhere((element) => element.data()['User Id'] == uid);
  print(UserData.docs.first.data());
  return user.data();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshor) {
            if (snapshor.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshor.data!.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future: getPosts((snapshor.data![index].data()
                          as Map<String, dynamic>)['User Id']),
                      builder: (context, futurSnapshot) {
                        if (futurSnapshot.hasData) {
                          return PostCard(
                          
                              name: futurSnapshot.data!['User name'],
                              place: 'Marakkana',
                              hrs: '3',
                              profile: futurSnapshot.data!['Profile Pic'],
                              imageUrl:
                                  "${(snapshor.data![index].data() as Map<String, dynamic>)['Image']}");
                        } else if (futurSnapshot.hasError) {
                          return Text(
                            'error',
                            style: TextStyle(color: Colors.white),
                          );
                        } else {
                          return Container();
                        }
                      });
                },
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
