import 'package:flutter/material.dart';
import 'package:golden_eyes/widgets/colors.dart';

class TextLink extends StatelessWidget {
  final BuildContext context;
  const TextLink({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '''Não possui uma conta? ''',
          softWrap: true,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 16.0,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/account/create'),
          child: Text(
            "Criar conta.",
            softWrap: true,
            style: TextStyle(
              color: COLOR_BROWN,
              fontSize: 16.0,
            ),
          ),
        )
      ],
    );
  }
}
