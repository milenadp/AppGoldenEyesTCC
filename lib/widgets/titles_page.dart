import 'package:flutter/material.dart';

class TitlePage extends Text {
  TitlePage(String title)
      : super(
          title,
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        );
}

class SubtitlePage extends StatelessWidget {
  final String subtitle;
  const SubtitlePage({Key? key, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(subtitle, style: TextStyle(fontSize: 20.0)),
    );
  }
}
