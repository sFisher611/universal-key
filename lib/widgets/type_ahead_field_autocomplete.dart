// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../models/universal.dart';

class TypeAheadFieldAutocomplete extends StatelessWidget {
  TypeAheadFieldAutocomplete({
    Key key,
    this.list,
    this.onSelected,
    this.textLabel,
    this.controller,
    this.icon = Icons.search,
    this.onPressedSuffix,
    this.focusNode,
    this.colorStyle = Colors.black,
  }) : super(key: key);
  Color colorStyle;
  List<UniversalModel> list;
  String textLabel;
  var icon;
  Function onSelected;
  Function onPressedSuffix;
  TextEditingController controller;
  FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TypeAheadField<UniversalModel>(
        getImmediateSuggestions: false,
        noItemsFoundBuilder: (context) {
          return const ListTile(
            title: Text(
              'Mavjud emas',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          );
        },
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: focusNode,
          controller: controller,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 17,
            fontFamily: "ComicNeue",
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
        suggestionsCallback: (String pattern) async {
          return list
              .where((item) =>
                  item.name.toLowerCase().contains(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, UniversalModel suggestion) {
          return ListTile(
            title: Text(suggestion.name),
          );
        },
        onSuggestionSelected: onSelected,
      ),
    );
  }
}
