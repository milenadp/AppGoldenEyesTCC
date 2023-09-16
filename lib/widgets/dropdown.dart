import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:golden_eyes/widgets/colors.dart';

class DefaultDropdown extends SizedBox {
  DefaultDropdown(List<String> list, String value, {required onChanged})
      : super(
          width: 330,
          child: DropdownSearch<String>(
            items: list,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                fillColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: COLOR_YELLOW),
                ),
              ),
            ),
            onChanged: onChanged,
            selectedItem: value,
          ),
        );
}
