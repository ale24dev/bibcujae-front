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
import 'add_or_edit_book.dart';

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
            if (widget.isFromSearch == null)
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: ((context) => const AddOrEditBook()));
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
}
