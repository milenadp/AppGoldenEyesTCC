import 'package:flutter/material.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/dropdown.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';
import 'package:golden_eyes/widgets/titles_page.dart';
import 'package:provider/provider.dart';
import '../../widgets/pop_message.dart';

class RolePage extends StatefulWidget {
  RolePage({Key? key}) : super(key: key);

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  late UserRepository userRepository;

  TextEditingController cpfController = TextEditingController();
  TextEditingController roleController = TextEditingController(text: "Função");

  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: roleForm()
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

  List<Widget> roleForm() {
    return [
      TitlePage("Cadastrar Função."),
      SubtitlePage(
          subtitle:
              "Por favor insira o CPF do novo usuário para selecionar a função."),
      DefaultTextFormField(text: "CPF", controller: cpfController),
      DefaultDropdown(['Administrador', 'Usuário'], roleController.text,
          onChanged: (value) {
        setState(() {
          roleController.text = value;
        });
      }),
      DefaultButton(text: "Cadastrar", onPressed: _sendUpdateRole),
    ];
  }

  _sendUpdateRole() async {
    if (cpfController.text.isEmpty || roleController.text == "Função") {
      await PopMessage(context, 'Aviso', 'Preencha todos os campos!');
      return;
    }

    if (await MainApi.user.updateRole(
        cpfController.text, roleController.text, userRepository.token)) {
      await PopMessage(context, '', 'Função cadastrada com sucesso!');
      Navigator.pop(context);
    } else {
      await PopMessage(context, '', 'Erro ao atualizar dados!');
    }
  }
}
