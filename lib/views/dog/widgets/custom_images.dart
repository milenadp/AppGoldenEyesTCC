import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:golden_eyes/widgets/colors.dart';

Widget GetImage({required onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(border: Border.all(color: COLOR_BROWN)),
      width: 330,
      height: 130,
      child: const Icon(
        Icons.add_photo_alternate_outlined,
        color: COLOR_BROWN,
        size: 40,
      ),
    ),
  );
}

Widget ShowImage(Widget image64, {required onPressed}) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: COLOR_BROWN)),
    width: 130,
    height: 130,
    child: badges.Badge(
      elevation: 1,
      badgeColor: Colors.white,
      badgeContent: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onPressed,
      ),
      child: Container(
        width: 100,
        height: 100,
        child: image64,
      ),
    ),
  );
}
