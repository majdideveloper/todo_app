import 'package:flutter/material.dart';
import 'package:todo_app/ui/theme.dart';

class MyButton extends StatelessWidget {
  MyButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.height,
  }) : super(key: key);

  final String label;
   double height = 45;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr,
        ),
        child: Text(
          label,
          style:TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500
          ) ,
          textAlign:TextAlign.center ,
        ),
      ),
    );
  }
}
