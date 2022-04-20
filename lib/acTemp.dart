import 'package:flutter/material.dart';
import 'controllingroundedRoundedActionButton.dart';
import 'constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AcTemp extends StatelessWidget {
  final VoidCallback onAdding;
  final VoidCallback onRemoving;
  final int airConditionerTemp;
  final bool uptoDate;
  AcTemp(
      {Key? key,
      required this.onAdding,
      required this.onRemoving,
      required this.airConditionerTemp,
      required this.uptoDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$airConditionerTemp°C',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            ControllingRoundedIconButton(
                                onPressed: onAdding, iconData: Icons.add),
                            ControllingRoundedIconButton(
                                onPressed: onRemoving, iconData: Icons.remove),
                          ],
                        )
                      ],
                    ),
                    const Icon(
                      Icons.ac_unit,
                      size: 70,
                      color: KBoldedContentColor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'AC temperature',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                uptoDate
                    ? const Icon(
                        Icons.done_sharp,
                        size: 20,
                      )
                    : LoadingAnimationWidget.inkDrop(
                        color: Colors.white, size: 15)
              ],
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1B2B),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
