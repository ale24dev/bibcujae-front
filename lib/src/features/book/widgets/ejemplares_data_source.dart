import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../shared/utils.dart';
import '../cubit/ejemplar_cubit.dart';
import 'delete ejemplar_dialog.dart';

class EjemplarDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EjemplarDataSource(
      {required List<dynamic> listEjemplaresBaseModel,
      required BuildContext context}) {
    _ctx = context;
    listEjemplares = listEjemplaresBaseModel
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Cod Barras', value: e.codBarras),
              DataGridCell<String>(
                  columnName: 'Subdivisión 1', value: e.subdivision1),
              DataGridCell<String>(
                  columnName: 'Subdivisión 2', value: e.subdivision2),
              DataGridCell<String>(columnName: 'Ubicación', value: e.ubicacion),
              DataGridCell<String>(columnName: 'Vías Adq', value: e.viasAdq),
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

  @override
  List<DataGridRow> get rows => listEjemplares;

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
              // child: Text(e.value.toString(),
              //     style: ctx.textTheme.bodyText1?.copyWith(fontSize: 12.sp)),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      print("Hola1");
                      showDialog(
                    context: ctx,
                    builder: ((context) => deleteEjemplarDialog(context, e.value)));
                      
                    },
                    color: Colors.red),
                SizedBox(width: 5.sp),
                IconButton(
                    icon: Icon(Icons.edit_square),
                    onPressed: () {
                      print("Hola1");
                    },
                    color: Colors.blue),
              ],
            );
    }).toList());
  }
}
