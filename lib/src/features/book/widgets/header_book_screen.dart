import 'package:bibcujae/src/models/book_base_model.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../resources/general_styles.dart';
import '../../../entities/book_page_entity.dart';
import '../../../repositories/book_repositories.dart';
import '../../../shared/constants/constants.dart';
import '../cubit/book_cubit.dart';

class HeaderBookScreen extends StatefulWidget {
  const HeaderBookScreen({
    super.key,
    required this.bookPageEntity,
    this.isFromSearch,
  });

  final BookPageEntity bookPageEntity;

  final bool? isFromSearch;

  @override
  State<HeaderBookScreen> createState() => _HeaderBookScreenState();
}

class _HeaderBookScreenState extends State<HeaderBookScreen> {
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController domCodeController;
  late TextEditingController isbnController;
  late TextEditingController deweyController;
  late TextEditingController publicationController;
  late TextEditingController colationController;
  late TextEditingController referenceController;

  bool emptyRequiredFields = false;

  @override
  void initState() {
    titleController = TextEditingController();
    authorController = TextEditingController();
    domCodeController = TextEditingController();
    isbnController = TextEditingController();
    deweyController = TextEditingController();
    publicationController = TextEditingController();
    colationController = TextEditingController();
    referenceController = TextEditingController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   authorController.dispose();
  //   domCodeController.dispose();
  //   isbnController.dispose();
  //   deweyController.dispose();
  //   publicationController.dispose();
  //   colationController.dispose();
  //   referenceController.dispose();
  //   super.dispose();
  // }

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
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
            SizedBox(width: 1.w),
            Container(
                decoration: BoxDecoration(
                    color: GStyles.colorPrimary,
                    borderRadius:
                        BorderRadius.circular(Constants.RADIO_BUTTONS)),
                child: Padding(
                  padding: EdgeInsets.all(6.sp),
                  child: Text(widget.bookPageEntity.count.toString(),
                      style: context.textTheme.bodyText1
                          ?.copyWith(color: Colors.white, fontSize: 12.sp)),
                ))
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                BookRepository bookRepository = BookRepository();
                bookRepository
                    .downloadBooksReport(widget.bookPageEntity.results);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius:
                          BorderRadius.circular(Constants.RADIO_BUTTONS)),
                  child: Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Constants.RADIO_BUTTONS)),
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
            if (widget.isFromSearch != null)
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: ((context) => addBookDialog(context)));
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.circular(Constants.RADIO_BUTTONS)),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      title: Center(
          child: Text("Añadir libro",
              style: context.textTheme.bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp))),
      children: [
        addbookSection(
            context: context,
            title: "Título",
            isRequired: true,
            controller: titleController),
        addbookSection(
            context: context, title: "Autor", controller: authorController),
        addbookSection(
            context: context,
            title: "Cod. Domicilio",
            controller: domCodeController),
        addbookSection(
            context: context, title: "ISBN", controller: isbnController),
        addbookSection(
            context: context, title: "Dewey", controller: deweyController),
        addbookSection(
            context: context,
            title: "Publicación",
            controller: publicationController),
        addbookSection(
            context: context,
            title: "Colación",
            controller: colationController),
        addbookSection(
            context: context,
            title: "Referencia",
            controller: referenceController),
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
                  onPressed: () {
                    if (titleController.text.isEmpty) {
                      setState(() {
                        emptyRequiredFields = true;
                      });
                    } else {
                      BookBaseModel book = BookBaseModel(
                          bookId: null,
                          title: titleController.text,
                          entry: null,
                          authorType: null,
                          author: authorController.text,
                          otherAuthors: null,
                          edition: null,
                          series: null,
                          notes: null,
                          publicationYear: null,
                          responsibilityMention: null,
                          domCode: null,
                          isbn: isbnController.text,
                          dewey: deweyController.text,
                          event: null,
                          otherEvents: null,
                          publication: publicationController.text,
                          collation: colationController.text,
                          otherTitles: null,
                          pamphlet: null,
                          reference: referenceController.text,
                          entryLetters: null,
                          titleLetters: null,
                          classification: null,
                          language: null,
                          country: null);

                      context.read<BookCubit>().createBook(bookBaseModel: book);
                    }
                  },
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
      bool? isRequired,
      required TextEditingController controller}) {
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
          controller: controller,
        ))
      ],
    );
  }
}
