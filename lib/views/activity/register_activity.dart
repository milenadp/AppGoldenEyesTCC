import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/models/dog.dart';
import 'package:golden_eyes/models/user.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/dropdown.dart';
import 'package:golden_eyes/widgets/mask_formarter.dart';
import 'package:golden_eyes/widgets/pop_message.dart';
import 'package:golden_eyes/widgets/text_form_field.dart';

class RegisterActivity extends StatefulWidget {
  final List<Dog> dogList;
  final List<User> coachList;
  RegisterActivity({
    Key? key,
    required this.dogList,
    required this.coachList,
  }) : super(key: key);

  @override
  State<RegisterActivity> createState() => _RegisterActivityState();
}

class _RegisterActivityState extends State<RegisterActivity> {
  List<String> dogNames = [];
  List<String> coachNames = [];

  var dropdownValueDog = 'Selecione o cão';
  var dropdownValueCoach = "Selecionar o treinador";

  List<Map> newActivityList = [];

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  String date = '';
  String street = '';
  String neighborhood = '';
  String city = '';
  String state = '';
  String description = '';

  @override
  void initState() {
    dogNames = [for (Dog dog in widget.dogList) dog.name];
    coachNames = [for (User coach in widget.coachList) coach.name];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(
        iconTheme: IconThemeData(color: COLOR_BROWN),
        elevation: 0,
        backgroundColor: COLOR_LIGHT_GREY,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode:
                _validate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              children: [
                Text("Registro diário.",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Data",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    MaskFormarter.birth.input_mask()
                  ],
                  onSaved: (String? value) {
                    date = value!;
                  },
                ),
                SizedBox(height: 30),
                DefaultDropdown(dogNames, dropdownValueDog, onChanged: (value) {
                  setState(() {
                    dropdownValueDog = value;
                  });
                }),
                SizedBox(height: 30),
                DefaultDropdown(coachNames, dropdownValueCoach,
                    onChanged: (value) {
                  setState(() {
                    dropdownValueCoach = value;
                  });
                }),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Rua",
                  onSaved: (String? value) {
                    street = value!;
                  },
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Bairro",
                  onSaved: (String? value) {
                    neighborhood = value!;
                  },
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Cidade",
                  onSaved: (String? value) {
                    city = value!;
                  },
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Estado",
                  onSaved: (String? value) {
                    state = value!;
                  },
                ),
                SizedBox(height: 30),
                DefaultTextFormField(
                  text: "Descrição",
                  maxLines: 5,
                  onSaved: (String? value) {
                    description = value!;
                  },
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    newActivityList =
                        await Navigator.pushNamed(context, '/activity/options')
                            as List<Map>;

                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: COLOR_LIGHT_GREY,
                      border: Border.all(
                        width: 2.5,
                        color: COLOR_YELLOW,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          newActivityList.isEmpty
                              ? "  Adicionar atividade"
                              : "  ${newActivityList.length} atividades",
                          style: TextStyle(
                            color: COLOR_BROWN,
                            fontSize: 18.0,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          color: COLOR_YELLOW,
                          child: Icon(
                            Icons.add,
                            color: COLOR_BROWN,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            String userId = [
              for (User coach in widget.coachList)
                if (coach.name == dropdownValueCoach) coach.id
            ][0];

            String dogId = [
              for (Dog dog in widget.dogList)
                if (dog.name == dropdownValueDog) dog.id
            ][0];

            Map activityData = {
              "date": DateCustom.StringDateToInt(date).toString(),
              "local": {
                "street": street,
                "neighborhood": neighborhood,
                "city": city,
                "state": state,
              },
              "description": description,
              "dog_id": dogId,
              "user_id": userId,
              "activity_list": newActivityList,
            };
            if (await MainApi.activity.dailyRegister(activityData)) {
              await PopMessage(
                  context, 'Cadastro', 'Registro cadastrado com sucesso!');

              Navigator.pushNamed(context, '/home');
            } else {
              await PopMessage(context, 'Erro', 'Erro ao registrar!');
            }
          } else {
            // erro de validação
            setState(() {
              _validate = true;
            });
          }
        },
        label: Text(
          'Registrar',
          style: TextStyle(
            fontSize: 15,
            color: COLOR_LIGHT_GREY,
          ),
        ),
        icon: Icon(
          FontAwesomeIcons.paw,
          color: COLOR_YELLOW,
        ),
        backgroundColor: COLOR_BROWN,
      ),
    );
  }
}
