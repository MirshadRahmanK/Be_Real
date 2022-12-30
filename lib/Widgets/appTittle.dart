import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAppTittle extends StatelessWidget {
  const CustomAppTittle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "BeReal",
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
