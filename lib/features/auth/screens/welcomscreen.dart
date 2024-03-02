// ignore_for_file: sort_child_properties_last, camel_case_types, unused_local_variable, unnecessary_import, prefer_const_constructors, prefer_const_declarations
import 'package:avatar_glow/avatar_glow.dart';
// import 'package:mytoys/common/widgets/custom_button.dart';
// import 'package:mytoys/common/widgets/custom_textfield.dart';
import 'package:mytoys/features/auth/screens/delayed_animation.dart';
import 'package:mytoys/features/auth/screens/auth_screen.dart';
// import 'package:mytoys/constants/global_variables.dart';
// import 'package:mytoys/features/auth/services/auth_service.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

// enum Auth {
//   signin,
//   signup,
// }

class welcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen>
    with TickerProviderStateMixin {
  final int delayedAmount = 500;
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF8185E2),
        body: Center(
          child: Column(
            children: <Widget>[
              AvatarGlow(
                endRadius: 100,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 2),
                startDelay: Duration(seconds: 1),
                child: Material(
                    // height: ,
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Image.asset(
                        'assets/images/mytoy_image.png',
                        width: 60,
                        height: 60,
                        color: Colors.black,
                      ),
                      radius: 50.0,
                    )),
              ),
              DelayedAnimation(
                child: Text(
                  "Hi Here is ",
                  style: TextStyle(
                      // height: screenHeight * 0.,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      // width: screenWidth * 1,
                      color: color),
                ),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Text(
                  textAlign: TextAlign.center,
                  "Best online Toy Shop...",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: color),
                ),
                delay: delayedAmount + 2000,
              ),
              const SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                child: Text(
                  "Get ready for adventure ",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Text(
                  "with our top-quality toys",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              const SizedBox(
                height: 100.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              const SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AuthScreen.routeName);
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    "I Already have An Account".toUpperCase(),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                ),
                delay: delayedAmount + 5000,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AuthScreen.routeName);
            },
            child: const Text(
              'You are new user',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8185E2),
              ),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
