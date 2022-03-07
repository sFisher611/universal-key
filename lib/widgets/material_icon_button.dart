
import 'package:flutter/material.dart';

class MaterialIconButton extends StatelessWidget {
  MaterialIconButton({
    Key key,
    @required this.size,
    @required this.onPressed,
    @required this.onLongPress,
  }) : super(key: key);

  final Size size;

  Function onPressed;
  Function onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: size.height * 0.08,
        height: size.height * 0.08,
        color: Colors.transparent,
        child: InkWell(
          onLongPress: () {
            onLongPress();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.black,
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            onPressed();
          },
          child: const Center(
            child: Icon(
              Icons.backspace_outlined,
              color: Colors.white60,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}