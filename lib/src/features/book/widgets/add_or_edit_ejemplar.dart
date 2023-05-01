import 'package:bibcujae/src/entities/ejemplar_entity.dart';
import 'package:bibcujae/src/models/ejemplar_base_model.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/book_base_model.dart';
import '../../../shared/utils.dart';
import '../constants/add_or_edit_enum.dart';
import '../cubit/ejemplar_cubit.dart';

Widget addOrEditEjemplarDialog({
  required BuildContext context,
  required BookBaseModel bookBaseModel,
  //required TextEditingController codBarrasController,
  required TextEditingController subdivision1Controller,
  required TextEditingController subdivision2Controller,
  required TextEditingController viaAdqController,
  required TextEditingController precioController,
  required TextEditingController procedenciaController,
  required TextEditingController ubicacionController,
  required AddOrEditEjemplarEnum addOrEditEjemplarEnum,
  String? ejemplarId,
}) {
  return SimpleDialog(
    contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
    title: Center(
        child: Text(
            addOrEditEjemplarEnum == AddOrEditEjemplarEnum.ADD
                ? "Añadir ejemplar"
                : "Actualizar ejemplar",
            style: context.textTheme.bodyText1
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp))),
    children: [
      addEjemplarSection(
          context: context,
          title: "Subdivisión 1",
          isRequired: true,
          controller: subdivision1Controller),
      addEjemplarSection(
          context: context,
          title: "Subdivisión 2",
          controller: subdivision2Controller),
      addEjemplarSection(
          context: context,
          title: "Vía de adquisición",
          controller: viaAdqController),
      addEjemplarSection(
          context: context,
          title: "Procedencia",
          controller: procedenciaController),
      addEjemplarSection(
          context: context,
          title: "Ubicación",
          controller: ubicacionController),
      addEjemplarSection(
          context: context, title: "Precio", controller: precioController),
      Container(
        margin: EdgeInsets.only(top: 2.h),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              child: Text("Cancelar",
                  style: context.textTheme.bodyText1
                      ?.copyWith(color: Colors.white)),
            ),
            SizedBox(width: 2.w),
            ElevatedButton(
                onPressed: () {
                  EjemplarEntity ejemplarEntity = EjemplarEntity(
                      book: bookBaseModel,
                      fechaIngreso: Utils.getCurrentDate(),
                      precio: double.tryParse(precioController.text),
                      procedencia: procedenciaController.text.isEmpty
                          ? null
                          : procedenciaController.text,
                      subdivision1: subdivision1Controller.text.isEmpty
                          ? null
                          : subdivision1Controller.text,
                      subdivision2: subdivision2Controller.text.isEmpty
                          ? null
                          : subdivision2Controller.text,
                      ubicacion: ubicacionController.text.isEmpty
                          ? null
                          : ubicacionController.text,
                      viaAdq: viaAdqController.text.isEmpty
                          ? null
                          : viaAdqController.text);
                  EjemplarBaseModel ejemplarBaseModel =
                      EjemplarBaseModel.parseEntityToModel(ejemplarEntity);
                  if (addOrEditEjemplarEnum == AddOrEditEjemplarEnum.ADD) {
                    context
                        .read<EjemplarCubit>()
                        .createEjemplar(ejemplarBaseModel);
                  } else {
                    context.read<EjemplarCubit>().updateEjemplar(
                        ejemplarBaseModel, ejemplarId!.toString());
                  }
                },
                child: Text(
                    addOrEditEjemplarEnum == AddOrEditEjemplarEnum.ADD
                        ? "Añadir"
                        : "Actualizar",
                    style: context.textTheme.bodyText1
                        ?.copyWith(color: Colors.white))),
          ],
        ),
      )
    ],
  );
}

Widget addEjemplarSection(
    {required BuildContext context,
    required String title,
    bool? isRequired,
    required TextEditingController controller}) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          style: context.textTheme.bodyText1,
          controller: controller,
          decoration: InputDecoration(
              labelStyle:
                  context.textTheme.bodyText1?.copyWith(color: Colors.grey),
              label: Text(title)),
        ),
      )
    ],
  );
}
