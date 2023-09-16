import 'package:flutter/material.dart';
import 'package:golden_eyes/widgets/colors.dart';

class DefaultButton extends SizedBox {
  DefaultButton({
    required String text,
    required onPressed,
    double width = 330,
    double fontSize = 20,
    Color color = COLOR_BROWN,
  }) : super(
          width: width,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize),
            ),
          ),
        );
}
