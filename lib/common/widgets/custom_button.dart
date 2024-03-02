// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:mytoys/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  // final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    // this.color, required ButtonStyle style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
            // color: color == null ? Colors.white : Colors.black,
            color: GlobalVariables.selectedNavBarColor),
      ),
      onPressed: onTap,
    );
  }
}
