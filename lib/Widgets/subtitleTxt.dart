import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SubtittleTXT extends StatelessWidget {
  String txt;
   SubtittleTXT({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(color: Colors.grey),
    );
  }
}
