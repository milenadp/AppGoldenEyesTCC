import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/widgets/colors.dart';

import 'widgets/listview_edit.dart';

class DogPage extends StatefulWidget {
  DogPage({Key? key}) : super(key: key);

  @override
  State<DogPage> createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(
        backgroundColor: COLOR_YELLOW,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          FutureBuilder(
            future: MainApi.dog.getAllDog(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null &&
                  snapshot.connectionState == ConnectionState.done) {
                return listViewEdit(snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/dog/register'),
        backgroundColor: COLOR_BROWN,
        child: Icon(
          FontAwesomeIcons.paw,
          color: COLOR_YELLOW,
        ),
      ),
    );
  }
}
