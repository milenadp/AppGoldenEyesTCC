import 'package:flutter/material.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';
import 'package:golden_eyes/widgets/titles_page.dart';

class RecoverPasswordPage extends StatefulWidget {
  RecoverPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_YELLOW,
      appBar: AppBar(backgroundColor: COLOR_YELLOW),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: recoverPasswordForm()
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: e,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> recoverPasswordForm() {
    return [
      TitlePage("Recuperar Senha."),
      SubtitlePage(
          subtitle:
              "Por favor insira seu endereço de e-mail. Você irá receber um link para criar uma nova senha via e-mail."),
      DefaultTextFormField(
        text: "E-mail",
      ),
      DefaultButton(text: "Enviar", onPressed: () {}),
    ];
  }
}
