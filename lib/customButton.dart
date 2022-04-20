import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTapping;
  final IconData theIconData;
  final String text;
  final bool state;
  final bool upToDate;
  CustomButton(
      {required this.theIconData,
      required this.text,
      required this.onTapping,
      required this.state,
      required this.upToDate});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTapping,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  theIconData,
                  size: 110,
                  color: KBoldedContentColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: KTitleTextStyle,
                      ),
                    ],
                  ),
                ),
                upToDate
                    ? Icon(
                        Icons.done_sharp,
                        size: 20,
                      )
                    : LoadingAnimationWidget.inkDrop(
                        color: Colors.white, size: 15)
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xFF0F1B2B),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: state ? KBottomContainerColor : Color(0xFF0D1826),
                  offset: Offset(0.0, 0.0), //(x,y)
                  blurRadius: state == true ? 7 : 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
