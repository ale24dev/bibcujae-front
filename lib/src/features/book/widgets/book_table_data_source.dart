// ignore_for_file: use_build_context_synchronously

import 'package:bibcujae/src/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../models/book_base_model.dart';
import 'add_or_edit_book.dart';
import 'delete_book_dialog.dart';
import 'delete_ejemplar_dialog.dart';

class BookDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  BookDataSource({
    required List<BookBaseModel> listBooksBaseModel,
    required BuildContext context,
  }) {
    _ctx = context;

    listBooks = listBooksBaseModel
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Título', value: e.title),
              DataGridCell<String>(columnName: 'Autor', value: e.author),
              DataGridCell<String>(
                  columnName: 'Cod de Domicilio', value: e.domCode),
              DataGridCell<String>(columnName: 'ISBN', value: e.isbn),
              DataGridCell<String>(columnName: 'Dewey', value: e.dewey),
              DataGridCell<String>(
                  columnName: 'Publicación', value: e.publication),
              DataGridCell<String>(columnName: 'Colación', value: e.collation),
              DataGridCell<String>(
                  columnName: 'Referencia', value: e.reference),
              DataGridCell<String>(
                  columnName: 'Gestionar', value: e.bookId.toString()),
            ]))
        .toList();
  }
  List<DataGridRow> listBooks = [];

  late BuildContext _ctx;

  @override
  List<DataGridRow> get rows => listBooks;

  @override
  BuildContext get ctx => _ctx;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return e.columnName != "Gestionar"
          ? Container(
              alignment: e.columnName == "Título" ||
                      e.columnName == "Autor" ||
                      e.columnName == "Publicación"
                  ? Alignment.centerLeft
                  : Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(e.value.toString()),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      showDialog(
                          context: ctx,
                          builder: ((context) => deleteBookDialog(
                              context: context, bookId: e.value)));
                    },
                    color: Colors.red),
                SizedBox(width: 5.sp),
                IconButton(
                    icon: const Icon(Icons.edit_square),
                    onPressed: () async {
                      BookBaseModel? bookBaseModel =
                          await Utils.getBookById(ctx, int.parse(e.value));
                      showDialog(
                          context: ctx,
                          builder: ((context) => AddOrEditBook(
                              bookBaseModel: bookBaseModel, bookId: e.value)));
                    },
                    color: Colors.blue),
              ],
            );
    }).toList());
  }
}
