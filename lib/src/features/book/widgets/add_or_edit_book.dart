import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/models/book_base_model.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddOrEditBook extends StatefulWidget {
  const AddOrEditBook({super.key, this.bookBaseModel, this.bookId});

  final BookBaseModel? bookBaseModel;

  final String? bookId;

  @override
  State<AddOrEditBook> createState() => _AddOrEditBookState();
}

class _AddOrEditBookState extends State<AddOrEditBook> {
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController domCodeController;
  late TextEditingController isbnController;
  late TextEditingController deweyController;
  late TextEditingController publicationController;
  late TextEditingController colationController;
  late TextEditingController referenceController;
  late TextEditingController entryController;
  late TextEditingController editionController;
  late TextEditingController eventController;
  late TextEditingController languageController;
  late TextEditingController annoPubController;

  bool emptyRequiredFields = false;

  void popContextCallback(String text) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: GStyles.colorPrimary,
          content: Text(text),
        ),
      );
      Navigator.pop(context);
    });
  }

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
    entryController = TextEditingController();
    editionController = TextEditingController();
    eventController = TextEditingController();
    languageController = TextEditingController();
    annoPubController = TextEditingController();

    if (widget.bookBaseModel != null) {
      ///Inicializamos los controladores
      titleController.text = widget.bookBaseModel!.title ?? "";
      authorController.text = widget.bookBaseModel!.author ?? "";
      domCodeController.text = widget.bookBaseModel!.domCode ?? "";
      isbnController.text = widget.bookBaseModel!.isbn ?? "";
      deweyController.text = widget.bookBaseModel!.dewey ?? "";
      publicationController.text = widget.bookBaseModel!.publication ?? "";
      colationController.text = widget.bookBaseModel!.collation ?? "";
      referenceController.text = widget.bookBaseModel!.reference ?? "";
      entryController.text = widget.bookBaseModel!.entry ?? "";
      editionController.text = widget.bookBaseModel!.edition ?? "";
      eventController.text = widget.bookBaseModel!.event ?? "";
      languageController.text = widget.bookBaseModel!.language ?? "";
      annoPubController.text = widget.bookBaseModel!.publicationYear ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      title: Center(
          child: Text(
              widget.bookBaseModel != null
                  ? "Actualizar libro"
                  : "Añadir libro",
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
                    BookBaseModel book = BookBaseModel(
                        bookId: null,
                        title: titleController.text.isEmpty
                            ? null
                            : titleController.text,
                        entry: entryController.text.isEmpty
                            ? null
                            : entryController.text,
                        author: authorController.text.isEmpty
                            ? null
                            : authorController.text,
                        edition: editionController.text.isEmpty
                            ? null
                            : editionController.text,
                        publicationYear: annoPubController.text.isEmpty
                            ? null
                            : annoPubController.text,
                        domCode: domCodeController.text.isEmpty
                            ? null
                            : domCodeController.text,
                        isbn: isbnController.text.isEmpty
                            ? null
                            : isbnController.text,
                        dewey: deweyController.text.isEmpty
                            ? null
                            : deweyController.text,
                        event: eventController.text.isEmpty
                            ? null
                            : eventController.text,
                        publication: publicationController.text.isEmpty
                            ? null
                            : publicationController.text,
                        collation: colationController.text.isEmpty
                            ? null
                            : colationController.text,
                        reference: referenceController.text.isEmpty
                            ? null
                            : referenceController.text,
                        authorType: null,
                        otherAuthors: null,
                        series: null,
                        notes: null,
                        responsibilityMention: null,
                        otherEvents: null,
                        otherTitles: null,
                        pamphlet: null,
                        entryLetters: null,
                        titleLetters: null,
                        classification: null,
                        language: null,
                        country: null);
                    if (widget.bookBaseModel == null) {
                      context.read<BookCubit>().createBook(bookBaseModel: book);
                    } else {
                      //TODO> ACTUALIZAR LIBRO
                      context.read<BookCubit>().updateBook(
                          bookBaseModel: book,
                          bookId: widget.bookId!,
                          popContextCallback: popContextCallback);
                    }
                  },
                  child: Text(
                      widget.bookBaseModel != null ? "Actualizar" : "Crear",
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
