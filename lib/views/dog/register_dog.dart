import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/tools/converter_image.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/mask_formarter.dart';
import 'package:golden_eyes/widgets/pop_message.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';
import 'package:file_picker/file_picker.dart';

import 'widgets/custom_images.dart';

class RegisterDog extends StatefulWidget {
  RegisterDog({Key? key}) : super(key: key);

  @override
  State<RegisterDog> createState() => _RegisterDogState();
}

class _RegisterDogState extends State<RegisterDog> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  String name = '';
  String breed = '';
  String birth = '';
  String sex = '';
  String control_number = '';
  String color = '';
  String image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(
        backgroundColor: COLOR_LIGHT_GREY,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode:
                _validate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              children: [
                Text("Cadastrar Cão.",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                image != ""
                    ? ShowImage(
                        Image.memory(base64Decode(image), fit: BoxFit.cover),
                        onPressed: () {
                          setState(() {
                            image = '';
                          });
                        },
                      )
                    : GetImage(onTap: _getImage),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Nome",
                  onSaved: (value) => name = value,
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    text: "Nº de Controle",
                    onSaved: (value) => control_number = value),
                SizedBox(height: 30),
                DefaultTextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      MaskFormarter.birth.input_mask()
                    ],
                    text: "Data nasc",
                    onSaved: (value) => birth = value),
                SizedBox(height: 30),
                DefaultTextFormField(
                    text: "Raça",
                    width: 330.0,
                    onSaved: (value) => breed = value),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Sexo",
                  onSaved: (value) => sex = value,
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Cor",
                  onSaved: (value) => color = value,
                ),
                SizedBox(height: 30),
                DefaultButton(text: "Cadastrar", onPressed: _sendRegisterDog),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      String image_64;

      image_64 = CustomConverter.file_to_base64((result.files.single.path)!);

      setState(() {
        image = image_64;
      });
    }
  }

  _sendRegisterDog() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map dogData = {
        "img": image,
        "name": name,
        "breed": breed,
        "sex": sex,
        "color": color,
        "birth": DateCustom.StringDateToInt(birth),
        "control_number": control_number,
      };
      if (await MainApi.dog.registerDog(dogData)) {
        await PopMessage(context, 'Cadastro', 'Cão cadastrado com sucesso!');

        Navigator.pushNamed(context, '/home');
      } else {
        await PopMessage(context, 'Erro', 'Erro ao cadastrar cão!');
      }
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }
}
