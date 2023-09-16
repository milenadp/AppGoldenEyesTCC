import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:golden_eyes/models/dog.dart';
import 'package:golden_eyes/widgets/colors.dart';

Widget listViewDog(List<Dog> listDogs) {
  return Expanded(
    child: ListView.separated(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
      itemCount: listDogs.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/activity/download',
              arguments: listDogs[index]),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 2.5,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListTile(
              leading: Container(
                height: 70,
                width: 70,
                child: listDogs[index].img != null &&
                        listDogs[index].img.isNotEmpty
                    ? Image.memory(
                        base64Decode(listDogs[index].img),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/logo_home.png',
                        fit: BoxFit.cover,
                      ),
              ),
              title: Text(
                listDogs[index].name,
                style: TextStyle(
                  color: COLOR_BROWN,
                  fontSize: 18.0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(listDogs[index].breed),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
    ),
  );
}
