import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../shared/utils.dart';
import 'delete_ejemplar_dialog.dart';

class EjemplarDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EjemplarDataSource(
      {required List<dynamic> listEjemplaresBaseModel,
      required BuildContext context,
      required Function editRowCallBack}) {
    _ctx = context;
    _editRowCallBack = editRowCallBack;
    listEjemplares = listEjemplaresBaseModel
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Cod Barras', value: e.codBarras),
              DataGridCell<String>(
                  columnName: 'Subdivisión 1', value: e.subdivision1),
              DataGridCell<String>(
                  columnName: 'Subdivisión 2', value: e.subdivision2),
              DataGridCell<String>(columnName: 'Ubicación', value: e.ubicacion),
              DataGridCell<String>(columnName: 'Vías Adq', value: e.viaAdq),
              DataGridCell<String>(
                  columnName: 'Precio', value: e.precio?.toString()),
              DataGridCell<String>(
                  columnName: 'Estado',
                  value: Utils.capitalize(e.estadoEjemplar.estado)),
              DataGridCell<String>(
                  columnName: 'Eliminar', value: e.ejemplarId.toString()),
            ]))
        .toList();
  }
  List<DataGridRow> listEjemplares = [];

  late BuildContext _ctx;

  late Function _editRowCallBack;

  @override
  List<DataGridRow> get rows => listEjemplares;

  @override
  Function get editRowCallBack => _editRowCallBack;

  @override
  BuildContext get ctx => _ctx;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return e.columnName != "Eliminar"
          ? Container(
              alignment: Alignment.center,
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
                          builder: ((context) =>
                              deleteEjemplarDialog(context, e.value)));
                    },
                    color: Colors.red),
                SizedBox(width: 5.sp),
                IconButton(
                    icon: const Icon(Icons.edit_square),
                    onPressed: () {
                      showDialog(
                          context: ctx,
                          builder: ((context) => editRowCallBack(e.value)));
                    },
                    color: Colors.blue),
              ],
            );
    }).toList());
  }
}
