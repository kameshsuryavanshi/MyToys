// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mytoys/constants/global_variables.dart';

class IconHoverEffect extends StatefulWidget {
  final IconData icon;
  final Color color;

  const IconHoverEffect({required this.icon, required this.color});

  @override
  _IconHoverEffectState createState() => _IconHoverEffectState();
}

class _IconHoverEffectState extends State<IconHoverEffect> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isHovering ? GlobalVariables.selectedNavBarColor : null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.all(10),
          child: Icon(
            widget.icon,
            color: _isHovering ? Colors.white : widget.color,
          ),
        ),
      ),
    );
  }
}
