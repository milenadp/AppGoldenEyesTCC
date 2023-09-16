import 'package:flutter/material.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/pop_message.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';
import 'package:golden_eyes/widgets/titles_page.dart';

class RegisterNewActivity extends StatefulWidget {
  RegisterNewActivity({Key? key}) : super(key: key);

  @override
  State<RegisterNewActivity> createState() => _RegisterNewActivityState();
}

class _RegisterNewActivityState extends State<RegisterNewActivity> {
  TextEditingController _nameActivityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: registerNewActivityForm()
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: e,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> registerNewActivityForm() {
    return [
      TitlePage("Cadastrar Atividade."),
      DefaultTextFormField(
        text: "Nome nova atividade",
        controller: _nameActivityController,
      ),
      DefaultButton(
        text: "Cadastrar",
        onPressed: () async {
          var data = {
            "name": _nameActivityController.text,
          };

          if (await MainApi.activity.registerActivity(data)) {
            await PopMessage(
                context, 'Cadastro', 'Atividade cadastrada com sucesso!');
         Navigator.pushNamed(context, '/home');
          } else {
            await PopMessage(context, 'Erro', 'Erro ao cadastrar atividade!');
          }
        },
      ),
    ];
  }
}
