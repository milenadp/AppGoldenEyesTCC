import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/models/dog.dart';
import 'package:golden_eyes/widgets/buttons.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/dropdown.dart';

import 'copy_widget.dart';

class RegisterDownload extends StatefulWidget {
  RegisterDownload({Key? key}) : super(key: key);

  @override
  State<RegisterDownload> createState() => _RegisterDownloadState();
}

class _RegisterDownloadState extends State<RegisterDownload> {
  String year = 'Selecione o ano';
  String mounth = 'Selecione o mês';
  List<String> mounths = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];
  List<String> years = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
  ];
  late Dog dog;

  String ticket = '';
  @override
  Widget build(BuildContext context) {
    dog = ModalRoute.of(context)!.settings.arguments as Dog;

    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(
        iconTheme: IconThemeData(color: COLOR_BROWN),
        elevation: 0,
        title: Text(
          "Download de registros",
          style: TextStyle(color: COLOR_BROWN),
        ),
        backgroundColor: COLOR_YELLOW,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              ListTile(
                leading: Container(
                  width: 100,
                  height: 100,
                  child: dog.img != null && dog.img.isNotEmpty
                      ? Image.memory(
                          base64Decode(dog.img),
                          fit: BoxFit.fitHeight,
                        )
                      : Image.asset(
                          'assets/images/logo_home.png',
                          fit: BoxFit.cover,
                        ),
                ),
                title: Text("Nome: ${dog.name}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nº de controle: ${dog.control_number}"),
                    Text("Data nasc. " + DateCustom.formatTimeStamp(dog.birth)),
                    Text("Raça: ${dog.breed}"),
                    Text("Sexo: ${dog.sex}"),
                    Text("Cor: ${dog.color}"),
                  ],
                ),
              ),
              SizedBox(height: 30),
              DefaultDropdown(mounths, mounth, onChanged: (value) {
                setState(() {
                  mounth = value;
                });
              }),
              SizedBox(height: 30),
              DefaultDropdown(years, year, onChanged: (value) {
                setState(() {
                  year = value;
                });
              }),
              SizedBox(height: 30),
              DefaultButton(
                  text: "Download",
                  onPressed: () async {
                    ticket = await MainApi.activity.getCSVREgister(
                        dog.id,
                        int.parse(year),
                        int.parse(mounths.indexOf(mounth).toString()) + 1);

                    setState(() {});
                    // final _url = Uri.parse(urlCsv);
                    // if (!await launchUrl(_url)) throw 'Could not launch $_url';
                  }),
                  SizedBox(height: 30),
              if (ticket != '') CopyWidget(ticket: ticket),
            ],
          ),
        ),
      ),
    );
  }
}
