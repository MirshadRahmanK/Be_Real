// import 'package:be_real/Screens/profilePicScreen.dart';
// import 'package:be_real/Widgets/appTittle.dart';
// import 'package:be_real/Widgets/continueButton.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class NameScreen extends StatefulWidget {
//   const NameScreen({super.key});

//   @override
//   State<NameScreen> createState() => _NameScreenState();
// }

// TextEditingController userNameController = TextEditingController();

// class _NameScreenState extends State<NameScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomAppTittle(),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 50),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: userNameController,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                           hintText: 'Name',
//                           hintStyle: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               'By tapping \"Continue\", you agree to our',
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Privacy Policy ',
//                   style: TextStyle(
//                       color: Colors.grey[600], fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'and ',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 Text(
//                   'Terms of Service.',
//                   style: TextStyle(
//                       color: Colors.grey[600], fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             GestureDetector(
//                 onTap: () async {
//                   await FirebaseFirestore.instance
//                       .collection('Users').doc('').set(data)
//                       .add({'Name': userNameController.text});
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return ProfilePicScreen();
//                   }));
//                 },
//                 child: ContinueButton(
//                   txt: 'Continue',
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
