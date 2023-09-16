import 'package:flutter/material.dart';
import 'package:golden_eyes/widgets/colors.dart';

Future PopMessage(BuildContext context, String title, String message) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message, textAlign: TextAlign.justify),
          actions: [
            TextButton(
              child: Text(
                "OK",
                style:
                    TextStyle(color: COLOR_BROWN, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

Future<bool> PopMessageConfirm(
    BuildContext context, String title, String message) async {
  return await PopMessageConfirm_raw(context, title, message) ?? false;
}

Future PopMessageConfirm_raw(BuildContext context, String title, String message,
    {onPressedYes, onPressedNo}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(
                "Não",
                style:
                    TextStyle(color: COLOR_BROWN, fontWeight: FontWeight.bold),
              ),
              onPressed: onPressedNo,
            ),
            TextButton(
              child: Text(
                "Sim",
                style:
                    TextStyle(color: COLOR_BROWN, fontWeight: FontWeight.bold),
              ),
              onPressed: onPressedYes,
            ),
          ],
        );
      });
}
