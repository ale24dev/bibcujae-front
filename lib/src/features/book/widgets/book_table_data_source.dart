import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../models/book_base_model.dart';

class BookDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  BookDataSource({required List<BookBaseModel> listBooksBaseModel}) {
    listBooks = listBooksBaseModel
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Título', value: e.title),
              DataGridCell<String>(columnName: 'Autor', value: e.author),
              DataGridCell<String>(
                  columnName: 'Cod de Domicilio', value: e.addressCode),
              DataGridCell<String>(columnName: 'ISBN', value: e.isbn),
              DataGridCell<String>(columnName: 'Dewey', value: e.dewey),
              DataGridCell<String>(
                  columnName: 'Publicación', value: e.publication),
              DataGridCell<String>(columnName: 'Colación', value: e.collation),
              DataGridCell<String>(
                  columnName: 'Referencia', value: e.reference),
            ]))
        .toList();
  }
  List<DataGridRow> listBooks = [];

  @override
  List<DataGridRow> get rows => listBooks;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
