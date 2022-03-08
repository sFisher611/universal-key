
import 'package:flutter/material.dart';

class MaterialNumberButton extends StatelessWidget {
  MaterialNumberButton(
      {Key key,
      @required this.size,
      @required this.onPressed,
      @required this.text})
      : super(key: key);

  final Size size;
  final String text;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: size.height * 0.08,
        height: size.height * 0.08,
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.black,
          borderRadius: BorderRadius.circular(5),
          onTap: text != ""
              ? () {
                  onPressed(text);
                }
              : null,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: 35, fontFamily: "ComicNeue"),
            ),
          ),
        ),
      ),
    );
  }
}