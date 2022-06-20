import 'package:flutter/material.dart';
import 'package:get/get.dart';

double kDefaultPadding = 16;
Color kPrimaryColor = Colors.blue;
String kPath = "";

void errorSnackBar({required String msg}) =>
    // Get.snackbar(
    //   title, msg,
    //   backgroundColor: Colors.red[300],
    //   snackPosition: SnackPosition.BOTTOM,
    //   margin: EdgeInsets.all(10.0),
    //   colorText: Colors.white,
    //   // forwardAnimationCurve: Curves.bounceInOut,
    // );
    Get.rawSnackbar(message: msg, backgroundColor: Colors.red.shade900);

void successSnackBar({required String title, required String msg}) =>
    Get.snackbar(
      title,
      msg,
      backgroundColor: kPrimaryColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10.0),
      colorText: Colors.white,
    );

const LinearGradient kPrimaryLinearGradient = LinearGradient(
  colors: <Color>[
    Color.fromARGB(255, 129, 52, 175),
    Color.fromARGB(255, 221, 42, 123),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
