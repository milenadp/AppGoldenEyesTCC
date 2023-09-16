import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/pop_message.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';
import 'package:provider/provider.dart';
import 'widgets/text_link.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isColor = true;

  String cpf = '';
  String password = '';
  late UserRepository userRepository;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context, listen: false);
    return Scaffold(
      backgroundColor: COLOR_YELLOW,
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          autovalidateMode:
              _validate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  width: 300,
                  child: Image.asset(
                    'assets/images/logo_login.png',
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    DefaultTextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      text: "CPF",
                      widthBorder: 2.0,
                      height: 60.0,
                      onSaved: (String? val) {
                        cpf = val!;
                      },
                    ),
                    SizedBox(height: 5),
                    DefaultTextFormField(
                      obscureText: true,
                      text: "Senha",
                      widthBorder: 2.0,
                      height: 60.0,
                      onSaved: (String? val) {
                        password = val!;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/account/recover_password');
                        },
                        child: Text(
                          """esqueceu sua senha?        """,
                          softWrap: true,
                          style: TextStyle(
                            color: COLOR_BROWN,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    DefaultButton(
                      text: "Entrar",
                      onPressed: _sendLogin,
                    ),
                    SizedBox(height: 30),
                    TextLink(context: context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendLogin() async {
    if (_key.currentState!.validate()) {
      // Sem erros na validação
      _key.currentState!.save();

      Map data = {
        'cpf': cpf,
        'password': password,
      };

      if ((await MainApi.login.login(context, data)) == 200) {
        return Navigator.pushNamed(context, '/home');
      }
    } else {
      await PopMessage(context, "Erro", "Preencha todos os campos.");
      setState(() {
        _validate = true;
      });
    }
  }
}
