import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/shared/constants/constants.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GenericButton extends StatelessWidget {
  const GenericButton(
      {super.key,
      required this.text,
      required this.callbackFunction,
      this.color,
      this.icon});

  final String text;

  final Function callbackFunction;

  final Color? color;

  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callbackFunction();
      },
      child: Container(
          decoration: BoxDecoration(
              color: color ?? GStyles.colorPrimary,
              borderRadius: BorderRadius.circular(Constants.RADIO_BUTTONS)),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon != null
                    ? const Icon(Icons.add, color: Colors.white)
                    : const SizedBox.shrink(),
                icon != null ? SizedBox(width: 5.sp) : const SizedBox.shrink(),
                Text(text,
                    style: context.textTheme.bodyText1
                        ?.copyWith(color: Colors.white)),
              ],
            ),
          )),
    );
  }
}
