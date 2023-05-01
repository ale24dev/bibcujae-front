import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../cubit/ejemplar_cubit.dart';

Widget deleteEjemplarDialog(BuildContext context, String ejemplarId) {
  return SimpleDialog(
    contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
    children: [
      Text("¿Seguro que desea eliminar este ejemplar?",
          style: context.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 13.sp)),
      SizedBox(height: 20.sp),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Text("Cancelar",
                  style: context.textTheme.bodyText1
                      ?.copyWith(color: Colors.white))),
          SizedBox(width: 2.w),
          ElevatedButton(
              onPressed: () {
                context.read<EjemplarCubit>().deleteEjemplar(ejemplarId);
              },
              child: Text("Aceptar",
                  style: context.textTheme.bodyText1
                      ?.copyWith(color: Colors.white))),
        ],
      )
    ],
  );
}
