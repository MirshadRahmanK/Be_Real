// import 'package:be_real/Screens/LoginScreen.dart';
// import 'package:be_real/Widgets/appTittle.dart';
// import 'package:be_real/Widgets/continueButton.dart';
// import 'package:be_real/Widgets/customTxt.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DateOfBirthScreen extends StatefulWidget {
//   String name;
//   DateOfBirthScreen({required this.name});

//   @override
//   State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
// }

// TextEditingController dayController = TextEditingController();
// TextEditingController monthController = TextEditingController();
// TextEditingController yearController = TextEditingController();

// class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomAppTittle(),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Hi ${widget.name}, when\'s your birthday?',
//                     style: TextStyle(color: Colors.white, fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(40),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: dayController,
//                       style: TextStyle(color: Colors.white),
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           hintText: 'DD',
//                           hintStyle: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 40)),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: monthController,
//                       style: TextStyle(color: Colors.white),
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           hintText: 'MM',
//                           hintStyle: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 40)),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: yearController,
//                       style: TextStyle(color: Colors.white),
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           hintText: 'YYYY',
//                           hintStyle: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 40)),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             CustomTxt(
//               txt: 'Only to make sure you\'re old enough to use ',
//             ),
//             CustomTxt(txt: 'BeReal.'),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GestureDetector(
//                   onTap: () async {
//                     final prif = await SharedPreferences.getInstance();
//                     await prif.setString('DDkey', dayController.text);
//                     await prif.setString('MonthKey', monthController.text);
//                     await prif.setString('YearKey', yearController.text);
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return LoginScreen();
//                     }));
//                   },
//                   child: ContinueButton(
//                     txt: 'Continue',
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
