
import 'package:flutter/material.dart';
import 'package:math_crud/models/password_position.dart';

class PasswordWidget extends StatelessWidget {
  PasswordWidget({
    Key key,
    @required this.passwordPosition,
  }) : super(key: key);
  PasswordPosition passwordPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(6),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: !passwordPosition.active ? Colors.white : Colors.blue,
              width: 2),
          boxShadow: !passwordPosition.active
              ? null
              : [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
        ),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: passwordPosition.text == "" ? null : Colors.white),
        ));
  }
}