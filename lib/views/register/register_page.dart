import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/pop_message.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';
import 'package:golden_eyes/widgets/titles_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name = '';
  String cpf = '';
  String email = '';
  String password = '';

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_YELLOW,
      appBar: AppBar(backgroundColor: COLOR_YELLOW),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _key,
            autovalidateMode:
                _validate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              children: registerFormList()
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> registerFormList() {
    return [
      TitlePage("Crie uma conta."),
      DefaultTextFormField(
        text: "Nome",
        onSaved: (String? val) {
          name = val!;
        },
      ),
      DefaultTextFormField(
        text: "CPF",
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onSaved: (String? val) {
          cpf = val!;
        },
      ),
      DefaultTextFormField(
        text: "E-mail",
        onSaved: (String? val) {
          email = val!;
        },
      ),
      DefaultTextFormField(
        text: "Senha",
        onSaved: (String? val) {
          password = val!;
        },
      ),
      DefaultButton(
        text: "Cadastrar",
        onPressed: _sendRegisterForm,
      ),
    ];
  }

  _sendRegisterForm() async {
    if (_key.currentState!.validate()) {
      // Sem erros na validação

      _key.currentState!.save();

      email = email.trim();

      var newUser = new Map();

      newUser = {
        "name": name,
        "cpf": cpf,
        "email": email,
        "password": password,
      };

      if (await MainApi.user.registerUser(newUser)) {
        await PopMessage(
            context, 'Cadastro', 'Cadastro realizado com sucesso!');
        Navigator.pushNamed(context, '/');
      } else {
        await PopMessage(
            context, 'Erro ao cadastrar', 'Tente novamente mais tarde');
      }
    } else {
      await PopMessage(context, "Erro", "Preencha todos os campos");
      setState(() {
        _validate = true;
      });
    }
  }
}
