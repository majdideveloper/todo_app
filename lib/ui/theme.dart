import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    scaffoldBackgroundColor:Colors.white ,
    primaryColor: darkGreyClr,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    scaffoldBackgroundColor:darkGreyClr ,
    primaryColor: Colors.white,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );

  
}
TextStyle get headingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      color:bluishClr ,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ));
  }

  TextStyle get subHeadingStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: bluishClr,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get titleStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: bluishClr,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get subTitleStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        
        color: Get.isDarkMode ? Colors.grey : Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  TextStyle get bodyStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  TextStyle get bodyTwoStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }