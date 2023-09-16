import 'package:flutter/material.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/models/activity.dart';
import 'package:golden_eyes/widgets/pop_message.dart';

class CustomListView extends StatefulWidget {
  final List<Activity> activitys;
  final Function? onTap;
  CustomListView({Key? key, required this.activitys, this.onTap})
      : super(key: key);

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
        itemCount: widget.activitys.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.activitys[index].name),
            trailing: GestureDetector(
                onTap: () async {
                  if (await MainApi.activity
                          .deleteActivity(widget.activitys[index].id) ==
                      200) {
                    await PopMessage(context, 'Atividade',
                        'Atividade deletada com sucesso!');
                  } else {
                    await PopMessage(
                        context, 'Erro', 'Erro ao deletar atividade!');
                  }
                },
                child: Icon(Icons.delete)),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
