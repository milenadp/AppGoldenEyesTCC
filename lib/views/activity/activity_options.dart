import 'package:flutter/material.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/models/activity.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:golden_eyes/widgets/dropdown.dart';

class ActivityOptions extends StatefulWidget {
  ActivityOptions({Key? key}) : super(key: key);

  @override
  State<ActivityOptions> createState() => _ActivityOptionsState();
}

class _ActivityOptionsState extends State<ActivityOptions> {
  List<String> subtitleList = [
    'Insuficiente',
    'Aceitável',
    'Desejável',
    'Não se aplica'
  ];

  List<Map> newActivityList = [];
  var activityList = [];
  var dropdownActivity = "Selecione o status";
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(
        title: Text(
          "Registre as atividades abaixo",
          style: TextStyle(color: COLOR_BROWN),
        ),
        elevation: 0,
        backgroundColor: COLOR_LIGHT_GREY,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: COLOR_BROWN,
          ),
          onPressed: () => Navigator.pop(context, newActivityList),
        ),
      ),
      body: FutureBuilder(
        future: MainApi.activity.getAllActivity(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null &&
              snapshot.connectionState == ConnectionState.done) {
            return listAtividades(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Padding listAtividades(List<Activity> activits) {
    if (isFirst) {
      activityList = activits;
      isFirst = false;
    }
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ListView.separated(
        itemCount: activityList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activityList[index].name,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: COLOR_BROWN),
              ),
              SizedBox(height: 10),
              DefaultDropdown(subtitleList, activityList[index].status,
                  onChanged: (value) {
                setState(() {
                  newActivityList.add({
                    "id": activityList[index].id,
                    "name": activityList[index].name,
                    "status": value
                  });

                  activityList[index].status = value;
                });
              }),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
      ),
    );
  }
}
