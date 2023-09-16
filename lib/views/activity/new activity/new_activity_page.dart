import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/views/activity/new%20activity/widgets/custom_listview.dart';
import 'package:golden_eyes/widgets/colors.dart';

class NewActivityPage extends StatefulWidget {
  NewActivityPage({Key? key}) : super(key: key);

  @override
  State<NewActivityPage> createState() => _NewActivityPageState();
}

class _NewActivityPageState extends State<NewActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(backgroundColor: COLOR_YELLOW, elevation: 0),
      body: Column(
        children: [
          SizedBox(height: 30),
          FutureBuilder(
            future: MainApi.activity.getAllActivity(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null &&
                  snapshot.connectionState == ConnectionState.done) {
                return CustomListView(
                  activitys: snapshot.data,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/activity/register_new_activity'),
        backgroundColor: COLOR_BROWN,
        child: Icon(
          FontAwesomeIcons.paw,
          color: COLOR_YELLOW,
        ),
      ),
    );
  }
}
