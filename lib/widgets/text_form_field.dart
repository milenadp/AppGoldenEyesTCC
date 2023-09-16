import 'package:flutter/material.dart';
import 'package:golden_eyes/widgets/colors.dart';

class DefaultTextFormField extends Container {
  DefaultTextFormField({
    double? height,
    double widthBorder = 1.0,
    keyboardType,
    maxLines = 1,
    required String? text,
    double width = 330,
    inputFormatters,
    onSaved,
    initialValue,
    obscureText = false,
    controller,
  }) : super(
          width: width,
          height: height,
          child: TextFormField(
            inputFormatters: inputFormatters,
            controller: controller,
            obscureText: obscureText,
            initialValue: initialValue,
            onSaved: onSaved,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: COLOR_LIGHT_GREY,
              labelText: text,
              labelStyle: TextStyle(
                color: COLOR_BROWN,
                fontSize: 18,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widthBorder,
                  color: COLOR_BROWN,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widthBorder,
                  color: COLOR_BROWN,
                ),
              ),
            ),
          ),
        );
}
