import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/pop_message.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late UserRepository userRepository;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context, listen: false);

    if (isFirstTime) {
      _nameController.text = userRepository.user.name;
      _emailController.text = userRepository.user.email;
      _cpfController.text = userRepository.user.cpf;
      isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(
        backgroundColor: COLOR_LIGHT_GREY,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async => await _confirmDelete(context),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _key,
            autovalidateMode:
                _validate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              children: [
                Text("Editar Dados.",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                DefaultTextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  text: "CPF",
                  controller: _cpfController,
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Nome",
                  controller: _nameController,
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "E-mail",
                  controller: _emailController,
                ),
                SizedBox(height: 30),
                DefaultButton(text: "Salvar", onPressed: _sendRegisterForm),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sendRegisterForm() async {
    if (_key.currentState!.validate()) {
      // Sem erros na validação

      _key.currentState!.save();

      Map<String, dynamic> updateUser = new Map();

      updateUser = {
        "name": _nameController.text,
        "email": _emailController.text.trim(),
        "cpf": _cpfController.text,
      };

      if (await MainApi.user.updateUser(
          updateUser, userRepository.user.id, userRepository.token)) {
        await PopMessage(
            context, 'Editar dados', 'Dados atualizados com sucesso!');
        await userRepository.refreshUser();
        setState(() {});
      } else {
        await PopMessage(context, 'Editar dados', 'Erro ao atualizar dados!');
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  _confirmDelete(BuildContext context) async {
    Widget cancelButton = TextButton(
      child: Text("Cancelar", style: TextStyle(color: COLOR_BROWN)),
      onPressed: () => Navigator.of(context).pop(),
    );

    Widget continueButton = TextButton(
      child: Text("Continuar", style: TextStyle(color: COLOR_BROWN)),
      onPressed: () async {
        if (!await MainApi.user
            .deleteUser(userRepository.user.id, userRepository.token)) {
          await PopMessage(context, 'Erro', 'Erro ao excluir usuário!');
          return Navigator.of(context).pop();
        }

        await PopMessage(
            context, 'Deletar conta', 'Sua conta foi deletada com sucesso!');
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Deletar conta!"),
      content: Text("Você tem certeza que deseja excluir sua conta?"),
      actions: [cancelButton, continueButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
