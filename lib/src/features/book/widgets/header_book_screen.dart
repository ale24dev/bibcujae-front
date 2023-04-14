import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../resources/general_styles.dart';
import '../../../entities/book_page_entity.dart';
import '../../../repositories/book_repositories.dart';
import '../../../shared/constants/constants.dart';

class HeaderBookScreen extends StatelessWidget {
  const HeaderBookScreen({
    super.key,
    required this.bookPageEntity,
  });

  final BookPageEntity bookPageEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Constants.MARGIN, vertical: 3.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Text(
              "Total de libros",
              style: context.textTheme.bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 1.w),
            Container(
                decoration: BoxDecoration(
                    color: GStyles.colorPrimary,
                    borderRadius: BorderRadius.circular(8.sp)),
                child: Padding(
                  padding: EdgeInsets.all(6.sp),
                  child: Text(bookPageEntity.count.toString(),
                      style: context.textTheme.bodyText1
                          ?.copyWith(color: Colors.white, fontSize: 11.sp)),
                ))
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                BookRepository bookRepository = BookRepository();
                bookRepository.downloadBooksReport(bookPageEntity.results);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5.sp)),
                  child: Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.sp)),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Row(
                          children: [
                            const Icon(Icons.file_download_outlined,
                                color: Colors.black),
                            SizedBox(width: 5.sp),
                            Text("Descargar csv",
                                style: context.textTheme.bodyText1
                                    ?.copyWith(color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            SizedBox(width: 2.w),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: ((context) => addBookDialog(context)));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5.sp)),
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Row(
                      children: [
                        const Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 5.sp),
                        Text("Añadir libro",
                            style: context.textTheme.bodyText1
                                ?.copyWith(color: Colors.white)),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ]),
    );
  }

  Widget addBookDialog(BuildContext context) {
    return SimpleDialog(
      contentPadding:
          EdgeInsets.symmetric(horizontal: Constants.MARGIN, vertical: 2.h),
      title: Center(
          child: Text("Añadir libro",
              style: context.textTheme.bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp))),
      children: [
        addbookSection(context: context, title: "Título", isRequired: true),
        addbookSection(context: context, title: "Autor"),
        addbookSection(context: context, title: "Cod. Domicilio"),
        addbookSection(context: context, title: "ISBN"),
        addbookSection(context: context, title: "Dewey"),
        addbookSection(context: context, title: "Publicación"),
        addbookSection(context: context, title: "Colación"),
        addbookSection(context: context, title: "Referencia"),
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
              SizedBox(width: 5.w),
              ElevatedButton(
                  onPressed: () {},
                  child: Text("Crear",
                      style: context.textTheme.bodyText1
                          ?.copyWith(color: Colors.white))),
            ],
          ),
        )
      ],
    );
  }

  Widget addbookSection(
      {required BuildContext context,
      required String title,
      bool? isRequired}) {
    return Row(
      children: [
        Container(
          width: 7.w,
          child: Row(
            children: [
              Text(title, style: context.textTheme.bodyText1),
              SizedBox(width: 4.sp),
              isRequired != null
                  ? Text(
                      "*",
                      style: context.textTheme.bodyText1
                          ?.copyWith(color: Colors.red),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
        SizedBox(width: 10.sp),
        Expanded(
            child: TextField(
          style: context.textTheme.bodyText1,
        ))
      ],
    );
  }
}
