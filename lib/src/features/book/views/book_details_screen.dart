import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/features/book/cubit/ejemplar_cubit.dart';
import 'package:bibcujae/src/shared/constants/constants.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:bibcujae/src/models/book_base_model.dart';

import '../../../../resources/assets.dart';
import '../widgets/ejemplar_section.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.bookBaseModel});

  final BookBaseModel bookBaseModel;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EjemplarCubit>().getEjemplaresByBook(widget.bookBaseModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GStyles.colorCrema,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Constants.MARGIN, vertical: 2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 30.h,
                    child: Image.asset(
                      AppAsset.book,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bookSection(
                            context: context,
                            name: "Título",
                            description: widget.bookBaseModel.title),
                        bookSection(
                            context: context,
                            name: "Autor",
                            description: widget.bookBaseModel.author),
                        bookSection(
                            context: context,
                            name: "Cod Domicilio",
                            description: widget.bookBaseModel.domCode),
                        bookSection(
                            context: context,
                            name: "ISBN",
                            description: widget.bookBaseModel.isbn),
                        bookSection(
                            context: context,
                            name: "Dewey",
                            description: widget.bookBaseModel.dewey),
                        bookSection(
                            context: context,
                            name: "Publicación",
                            description: widget.bookBaseModel.publication),
                        bookSection(
                            context: context,
                            name: "Colación",
                            description: widget.bookBaseModel.collation),
                        bookSection(
                            context: context,
                            name: "Referencia",
                            description: widget.bookBaseModel.reference),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bookSection(
                            context: context,
                            name: "Entrada",
                            description: widget.bookBaseModel.entry),
                        bookSection(
                            context: context,
                            name: "Edición",
                            description: widget.bookBaseModel.edition),
                        bookSection(
                            context: context,
                            name: "Evento",
                            description: widget.bookBaseModel.event),
                        bookSection(
                            context: context,
                            name: "Idioma",
                            description: widget.bookBaseModel.language),
                        bookSection(
                            context: context,
                            name: "Año de pub.",
                            description: widget.bookBaseModel.publicationYear),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Notas",
                      style: context.textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 13.sp)),
                  SizedBox(height: 1.h),
                  Container(
                    decoration: BoxDecoration(
                        color: GStyles.colorCrema,
                        borderRadius:
                            BorderRadius.circular(Constants.RADIO_BUTTONS),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: .3,
                              blurRadius: .3)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: Text(
                          widget.bookBaseModel.notes != null
                              ? widget.bookBaseModel.notes!.isEmpty
                                  ? "No hay notas"
                                  : widget.bookBaseModel.notes!
                              : "No hay notas",
                          style: context.textTheme.bodyText1),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.sp),

            ///Sección de ejemplares
            EjemplaresSection(bookBaseModel: widget.bookBaseModel)
          ],
        ),
      ),
    );
  }

  Widget bookSection(
      {required BuildContext context,
      required String name,
      String? description}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 7.w,
            child: Text("$name: ",
                textAlign: TextAlign.left,
                style: context.textTheme.bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp)),
          ),
          SizedBox(width: 10.sp),
          Expanded(
            child: Text(
                description != null
                    ? description.isEmpty
                        ? "-"
                        : description
                    : "-",
                overflow: TextOverflow.clip,
                style: context.textTheme.bodyText1?.copyWith(fontSize: 12.sp)),
          ),
        ],
      ),
    );
  }
}
