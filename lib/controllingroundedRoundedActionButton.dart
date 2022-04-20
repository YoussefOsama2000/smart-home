import 'package:flutter/material.dart';
import 'constants.dart';

class ControllingRoundedIconButton extends StatelessWidget {
  VoidCallback onPressed;
  VoidCallback? onLongPressed;
  IconData iconData;
  ControllingRoundedIconButton(
      {required this.onPressed, this.onLongPressed, required this.iconData});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      onPressed: onPressed,
      onLongPress: onLongPressed,
      constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
      fillColor: KContentColor,
      child: Center(
        child: Icon(iconData),
      ),
      elevation: 9.0,
      highlightElevation: 2.0,
    );
  }
}
