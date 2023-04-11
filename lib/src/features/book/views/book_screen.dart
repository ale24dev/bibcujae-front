import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/shared/constants/constants.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../entities/book_page_entity.dart';
import '../../../repositories/book_repositories.dart';
import '../constants/pagination.dart';
import '../widgets/book_table_data_source.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late BookDataSource bookDataSource;
  late BookPageEntity bookPageEntity;

  int rowsSelected = 0;
  @override
  Widget build(BuildContext context) {
    print(rowsSelected);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            var cubit = context.read<BookCubit>();
            if (state is BookLoaded) {
              bookDataSource = BookDataSource(
                  listBooksBaseModel: state.apiResult.responseObject.results);
              bookPageEntity = state.apiResult.responseObject;
            }
            switch (state.runtimeType) {
              case BookLoading:
                return const Center(child: CircularProgressIndicator());

              case BookLoaded:
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Constants.MARGIN, vertical: 3.h),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    child: Padding(
                                      padding: EdgeInsets.all(6.sp),
                                      child: Text(
                                          bookPageEntity.count.toString(),
                                          style: context.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 11.sp)),
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
                                          borderRadius:
                                              BorderRadius.circular(5.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.all(3.sp),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.sp)),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.sp),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    Icons
                                                        .file_download_outlined,
                                                    color: Colors.black),
                                                SizedBox(width: 5.sp),
                                                Text("Descargar csv",
                                                    style: context
                                                        .textTheme.bodyText1
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                SizedBox(width: 2.w),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(5.sp)),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.add,
                                              color: Colors.white),
                                          SizedBox(width: 5.sp),
                                          Text("Añadir libro",
                                              style: context.textTheme.bodyText1
                                                  ?.copyWith(
                                                      color: Colors.white)),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ]),
                    ),
                    Expanded(
                      child: SfDataGrid(
                        // onSelectionChanged: (addedRows, removedRows) {
                        //   addedRows.isEmpty
                        //       ? rowsSelected -= 1
                        //       : rowsSelected += 1;
                        // },
                        //checkboxShape: [],
                        //selectionMode: SelectionMode.multiple,
                        //showCheckboxColumn: true,
                        // checkboxColumnSettings:
                        //     const DataGridCheckboxColumnSettings(
                        //         showCheckboxOnHeader: true),
                        gridLinesVisibility: GridLinesVisibility.horizontal,
                        columnResizeMode: ColumnResizeMode.onResizeEnd,
                        source: bookDataSource,
                        columnWidthMode: ColumnWidthMode.fill,
                        allowSorting: true,
                        columns: <GridColumn>[
                          gridColumn(name: 'Título'),
                          gridColumn(name: 'Autor'),
                          gridColumn(name: 'Cod Domicilio'),
                          gridColumn(name: 'ISBN'),
                          gridColumn(name: 'Dewey'),
                          gridColumn(name: 'Publicación'),
                          gridColumn(name: 'Colación'),
                          gridColumn(name: 'Referencia'),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: bookPageEntity.previous != null
                                ? () {
                                    context.read<BookCubit>().loadBooks(
                                        url: bookPageEntity.previous,
                                        paginationBook:
                                            PaginationBook.PREVIOUS);
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
                                          BorderRadius.circular(8.sp)),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.sp),
                                    child: Text("Anterior",
                                        style: context.textTheme.bodyText1
                                            ?.copyWith(
                                                color:
                                                    bookPageEntity.previous !=
                                                            null
                                                        ? Colors.white
                                                        : Colors.black)),
                                  )),
                            ),
                          ),
                          Text(
                            "Página ${cubit.indexPage} de ${bookPageEntity.count / cubit.ITEMS_BY_PAGE}",
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
                                          BorderRadius.circular(8.sp)),
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
                );
              default:
                Center(child: Text(state.props.first.toString()));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  GridColumn gridColumn({required String name}) {
    return GridColumn(
        //maximumWidth: 40.w,
        columnName: name,
        label: Container(
            //width: 40.w,
            padding: EdgeInsets.all(8.sp),
            alignment: Alignment.center,
            child: Text(
              name,
              style: context.textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )));
  }
}
