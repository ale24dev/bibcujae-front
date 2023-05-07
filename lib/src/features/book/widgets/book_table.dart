// ignore_for_file: use_build_context_synchronously

import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/entities/book_page_entity.dart';
import 'package:bibcujae/src/features/book/constants/pagination.dart';
import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/models/book_base_model.dart';
import 'package:bibcujae/src/shared/constants/constants.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:bibcujae/src/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'book_table_data_source.dart';
import 'header_book_screen.dart';

class BookTable extends StatelessWidget {
  const BookTable(
      {super.key,
      required this.bookPageEntity,
      required this.bookDataSource,
      this.decoration});

  final BookPageEntity bookPageEntity;

  final BookDataSource bookDataSource;

  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Column(
        children: [
          ///Cabecera de la vista libros
          HeaderBookScreen(bookPageEntity: bookPageEntity),
          Expanded(
            child: SfDataGrid(
              source: bookDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              allowSorting: true,
              onCellTap: (details) async {
                BookBaseModel? bookSelected = await Utils.getBookById(
                    context,
                    bookPageEntity
                        .results[details.rowColumnIndex.rowIndex - 1].bookId!);
                context.read<BookCubit>().selectBook(bookSelected);

                if (details.rowColumnIndex.rowIndex != 0) {
                  context.go(Uri(path: '/book', queryParameters: {
                    'idBook': bookPageEntity
                        .results[details.rowColumnIndex.rowIndex - 1].bookId
                        .toString()
                  }).toString());
                }
              },
              columns: <GridColumn>[
                gridColumn(context: context, name: 'Título'),
                gridColumn(context: context, name: 'Autor'),
                gridColumn(context: context, name: 'Cod Domicilio'),
                gridColumn(context: context, name: 'ISBN'),
                gridColumn(context: context, name: 'Dewey'),
                gridColumn(context: context, name: 'Publicación'),
                gridColumn(context: context, name: 'Colación'),
                gridColumn(context: context, name: 'Referencia'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: bookPageEntity.previous != null
                      ? () {
                          context.read<BookCubit>().loadBooks(
                              url: bookPageEntity.previous,
                              paginationBook: PaginationBook.PREVIOUS);
                        }
                      : null,
                  child: Padding(
                    padding: EdgeInsets.all(4.5.sp),
                    child: Container(
                        decoration: BoxDecoration(
                            color: bookPageEntity.previous != null
                                ? GStyles.colorPrimary
                                : Colors.grey,
                            borderRadius:
                                BorderRadius.circular(Constants.RADIO_BUTTONS)),
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Text("Anterior",
                              style: context.textTheme.bodyText1
                                  ?.copyWith(color: Colors.white)),
                        )),
                  ),
                ),
                Text(
                  "Página ${bookPageEntity.currentPage} de ${bookPageEntity.numPages}",
                  style: context.textTheme.bodyText1
                      ?.copyWith(color: Colors.black),
                ),
                InkWell(
                  onTap: bookPageEntity.next != null
                      ? () {
                          context.read<BookCubit>().loadBooks(
                              url: bookPageEntity.next,
                              paginationBook: PaginationBook.NEXT);
                        }
                      : null,
                  child: Padding(
                    padding: EdgeInsets.all(4.5.sp),
                    child: Container(
                        decoration: BoxDecoration(
                            color: GStyles.colorPrimary,
                            borderRadius:
                                BorderRadius.circular(Constants.RADIO_BUTTONS)),
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Text("Siguiente",
                              style: context.textTheme.bodyText1
                                  ?.copyWith(color: Colors.white)),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  GridColumn gridColumn({required BuildContext context, required String name}) {
    return GridColumn(
        //maximumWidth: 40.w,
        columnName: name,
        label: Container(
            //width: 40.w,
            padding: EdgeInsets.all(8.sp),
            alignment: Alignment.center,
            child: Text(
              name,
              style: context.textTheme.bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
            )));
  }
}
