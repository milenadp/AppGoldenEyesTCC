import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/models/dog.dart';
import 'package:golden_eyes/tools/converter_image.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/mask_formarter.dart';
import 'package:golden_eyes/widgets/pop_message.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';

import 'widgets/custom_images.dart';

class EditDog extends StatefulWidget {
  EditDog({Key? key}) : super(key: key);

  @override
  State<EditDog> createState() => _EditDogState();
}

class _EditDogState extends State<EditDog> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isFirst = true;
  late Dog dog;
  String image = '';

  @override
  Widget build(BuildContext context) {
    if (_isFirst) {
      dog = ModalRoute.of(context)!.settings.arguments as Dog;
      if (dog.img != null && dog.img.isNotEmpty) {
        image = dog.img;
      }
      _isFirst = false;
    }

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
                Text("Editar Cão.",
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
                  initialValue: dog.name,
                  text: "Nome",
                  onSaved: (value) => dog.name = value,
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    initialValue: dog.control_number,
                    text: "Nº de Controle",
                    onSaved: (value) => dog.control_number = value),
                SizedBox(height: 30),
                DefaultTextFormField(
                    initialValue: DateCustom.formatTimeStamp(dog.birth),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      MaskFormarter.birth.input_mask()
                    ],
                    text: "Data nasc",
                    onSaved: (value) =>
                        dog.birth = DateCustom.StringDateToInt(value)),
                SizedBox(height: 30),
                DefaultTextFormField(
                    initialValue: dog.breed,
                    text: "Raça",
                    width: 330.0,
                    onSaved: (value) => dog.breed = value),
                SizedBox(height: 30),
                DefaultTextFormField(
                  initialValue: dog.sex,
                  text: "Sexo",
                  width: 330.0,
                  onSaved: (value) => dog.sex = value,
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                  initialValue: dog.color,
                  text: "Cor",
                  width: 330.0,
                  onSaved: (value) => dog.color = value,
                ),
                SizedBox(height: 30),
                DefaultButton(
                    text: "Salvar",
                    color: Color.fromRGBO(102, 187, 106, 1),
                    onPressed: _sendRegisterDog),
                SizedBox(height: 20),
                DefaultButton(
                    text: "Deletar",
                    color: Colors.red,
                    onPressed: _sendDeleteDog),
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
        "name": dog.name,
        "breed": dog.breed,
        "sex": dog.sex,
        "color": dog.color,
        "birth": dog.birth,
        "control_number": dog.control_number,
      };
      if (await MainApi.dog.updateDog(dogData, dog.id)) {
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

  _sendDeleteDog() async {
    if (await MainApi.dog.deleteDog(dog.id) == 200) {
      await PopMessage(context, 'Deletar Cão', 'Cão deletado com sucesso!');

      Navigator.pushNamed(context, '/home');
    } else {
      await PopMessage(context, 'Erro', 'Erro ao deletar cão!');
    }
  }
}
