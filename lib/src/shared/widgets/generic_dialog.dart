import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GenericDialog extends StatelessWidget {
  const GenericDialog({super.key, this.title, required this.text});

  final String? title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title ?? "Ha ocurrido un error",
          style: context.textTheme.bodyText1!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp)),
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              SizedBox(
                  width: 35.w,
                  child: Text(text,
                      overflow: TextOverflow.clip,
                      style: context.textTheme.bodyText1)),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GStyles.colorFail),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Cerrar",
                          style: context.textTheme.bodyText1!
                              .copyWith(color: Colors.white)),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
