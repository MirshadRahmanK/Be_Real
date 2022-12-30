import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  String txt;
   ContinueButton({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
