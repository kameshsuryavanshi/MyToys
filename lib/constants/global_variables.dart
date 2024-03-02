import 'package:flutter/material.dart';

String uri = 'http://192.168.102.191:4000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 224, 176, 255),
      Color.fromARGB(255, 224, 176, 255),

      // Color.fromARGB(255, 255, 20, 147),
    ],
    stops: [0.5, 1.0],
  );

  // static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const secondaryColor = Color.fromRGBO(219, 112, 147, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromARGB(255, 232, 48, 165); //!
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Sport',
      'image': 'assets/images/sports.png',
    },
    {
      'title': 'Remote',
      'image': 'assets/images/remote.png',
    },
    {
      'title': 'Vehicle',
      'image': 'assets/images/car.png',
    },
    {
      'title': 'Education',
      'image': 'assets/images/education.png',
    },
    {
      'title': 'Teddy',
      'image': 'assets/images/teddy.png',
    },
    {
      'title': 'Innovative',
      'image': 'assets/images/innovative.png',
    },
  ];
}
