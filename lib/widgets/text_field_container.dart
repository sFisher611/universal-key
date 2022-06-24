import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldContainer extends StatelessWidget {
  TextFieldContainer({
    Key key,
    @required this.controller,
    @required this.title,
    this.enable = true,
    this.keyboardType,
    this.onSubmitted,
  }) : super(key: key);
  String title;
  TextEditingController controller;
  bool enable;
  TextInputType keyboardType;
  Function onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontFamily: "ComicNeue",
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onSubmitted: onSubmitted,
            enabled: enable,
            keyboardType: keyboardType,
            inputFormatters: [MyFormater()],
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 17,
              fontFamily: "ComicNeue",
            ),
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }
}

class MyFormater extends TextInputFormatter {
  static String defaultFormat(String text) {
    // Do whatever you want
    return text + '1';
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Your validations/formats
    // print("old value:" + oldValue.text);
    // print("new value:" + newValue.text);
    return null;
  }
}
