import 'package:bibcujae/src/features/book/cubit/ejemplar_cubit.dart';
import 'package:bibcujae/src/features/book/widgets/ejemplar_data_source.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../resources/general_styles.dart';
import '../../../models/book_base_model.dart';
import '../../../models/ejemplar_base_model.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/utils.dart';
import '../constants/add_or_edit_enum.dart';
import 'add_or_edit_ejemplar.dart';

class EjemplaresSection extends StatefulWidget {
  const EjemplaresSection({
    super.key,
    required this.bookBaseModel,
  });
  final BookBaseModel bookBaseModel;
  @override
  State<EjemplaresSection> createState() => _EjemplaresSectionState();
}

class _EjemplaresSectionState extends State<EjemplaresSection> {
  late TextEditingController subdivision1Controller;
  late TextEditingController subdivision2Controller;
  late TextEditingController viaAdqController;
  late TextEditingController precioController;
  late TextEditingController procedenciaController;
  late TextEditingController ubicacionController;

  @override
  void initState() {
    super.initState();
    subdivision1Controller = TextEditingController();
    subdivision2Controller = TextEditingController();
    viaAdqController = TextEditingController();
    precioController = TextEditingController();
    procedenciaController = TextEditingController();
    ubicacionController = TextEditingController();
  }

  @override
  void dispose() {
    subdivision1Controller.dispose();
    subdivision2Controller.dispose();
    viaAdqController.dispose();
    precioController.dispose();
    procedenciaController.dispose();
    ubicacionController.dispose();
    super.dispose();
  }

  dynamic editEjemplarDialogCallback(String ejemplarId) {
    ///Obtener el ejemplar a partir del id enviado por parametro
    EjemplarBaseModel ejemplar = Utils.getEjemplarById(
        context.read<EjemplarCubit>().listEjemplares, ejemplarId);

    ///Inicializamos los controladores
    subdivision1Controller.text = ejemplar.subdivision1 ?? "";
    subdivision2Controller.text = ejemplar.subdivision2 ?? "";
    precioController.text = ejemplar.precio?.toString() ?? "";
    procedenciaController.text = ejemplar.procedencia ?? "";
    ubicacionController.text = ejemplar.ubicacion ?? "";
    viaAdqController.text = ejemplar.viaAdq ?? "";

    return addOrEditEjemplarDialog(
        context: context,
        precioController: precioController,
        procedenciaController: procedenciaController,
        subdivision1Controller: subdivision1Controller,
        subdivision2Controller: subdivision2Controller,
        ubicacionController: ubicacionController,
        viaAdqController: viaAdqController,
        bookBaseModel: widget.bookBaseModel,
        addOrEditEjemplarEnum: AddOrEditEjemplarEnum.EDIT,
        ejemplarId: ejemplarId);
  }

  @override
  Widget build(BuildContext context) {
    late List<dynamic> listEjemplaresOfBook;
    EjemplarDataSource? ejemplarDataSource;

    return Expanded(
      child: BlocBuilder<EjemplarCubit, EjemplarState>(
        builder: (context, state) {
          if (state is EjemplarLoaded) {
            listEjemplaresOfBook = state.apiResult.responseObject;
            ejemplarDataSource = EjemplarDataSource(
                listEjemplaresBaseModel: listEjemplaresOfBook,
                context: context,
                editRowCallBack: editEjemplarDialogCallback);
          }
          switch (state.runtimeType) {
            case EjemplarLoading:
              return const Center(child: CircularProgressIndicator());

            case EjemplarEmpty:
              return Center(
                  child: Text("Este libro no tiene ejemplares en existencia",
                      style: context.textTheme.bodyText1));

            case EjemplarCreated:
              print("llegue");
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ///Cerramos el dialog de añadir ejemplar
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: ((context) => codBarrasGenerated(
                        (state as EjemplarCreated).apiResult.responseObject)));
                context
                    .read<EjemplarCubit>()
                    .getEjemplaresByBook(widget.bookBaseModel);
              });

              // return Center(
              //     child: (state as EjemplarCreated).apiResult.responseObject);
              return const Center(child: CircularProgressIndicator());
            case EjemplarUpdated:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: GStyles.colorPrimary,
                    content: const Text('Ejemplar actualizado correctamente'),
                  ),
                );

                ///Cerramos el dialog de eliminar ejemplar
                Navigator.pop(context);
                context
                    .read<EjemplarCubit>()
                    .getEjemplaresByBook(widget.bookBaseModel);
              });
              // return Center(
              //     child: (state as EjemplarCreated).apiResult.responseObject);
              return const Center(child: CircularProgressIndicator());

            case EjemplarDeleted:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: GStyles.colorPrimary,
                    content: const Text('Ejemplar eliminado correctamente'),
                  ),
                );

                ///Cerramos el dialog de eliminar ejemplar
                Navigator.pop(context);
                context
                    .read<EjemplarCubit>()
                    .getEjemplaresByBook(widget.bookBaseModel);
              });

              return const Center(child: CircularProgressIndicator());

            case EjemplarLoaded:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ejemplares",
                          style: context.textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 13.sp)),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) =>
                                      addOrEditEjemplarDialog(
                                          context: context,
                                          precioController: precioController,
                                          procedenciaController:
                                              procedenciaController,
                                          subdivision1Controller:
                                              subdivision1Controller,
                                          subdivision2Controller:
                                              subdivision2Controller,
                                          ubicacionController:
                                              ubicacionController,
                                          viaAdqController: viaAdqController,
                                          bookBaseModel: widget.bookBaseModel,
                                          addOrEditEjemplarEnum:
                                              AddOrEditEjemplarEnum.ADD)));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: GStyles.colorPrimary,
                                    borderRadius: BorderRadius.circular(
                                        Constants.RADIO_BUTTONS)),
                                child: Padding(
                                  padding: EdgeInsets.all(3.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: GStyles.colorPrimary,
                                        borderRadius: BorderRadius.circular(
                                            Constants.RADIO_BUTTONS)),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.add,
                                              color: Colors.white),
                                          SizedBox(width: 5.sp),
                                          Text("Añadir ejemplar",
                                              style: context.textTheme.bodyText1
                                                  ?.copyWith(
                                                      color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(width: 5.sp),
                          InkWell(
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(
                                        Constants.RADIO_BUTTONS)),
                                child: Padding(
                                  padding: EdgeInsets.all(3.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                            Constants.RADIO_BUTTONS)),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.bookmark_add,
                                              color: Colors.white),
                                          SizedBox(width: 5.sp),
                                          Text("Realizar préstamo",
                                              style: context.textTheme.bodyText1
                                                  ?.copyWith(
                                                      color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
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
                      source: ejemplarDataSource!,
                      columnWidthMode: ColumnWidthMode.fill,
                      allowSorting: true,
                      onCellTap: (details) {},
                      columns: <GridColumn>[
                        gridColumn(name: 'Cod Barras', context: context),
                        gridColumn(name: 'Subdivisión 1', context: context),
                        gridColumn(name: 'Subdivisión 2', context: context),
                        gridColumn(name: 'Ubicación', context: context),
                        gridColumn(name: 'Vías Adquisición', context: context),
                        gridColumn(name: 'Precio', context: context),
                        gridColumn(name: 'Estado', context: context),
                        gridColumn(name: '', context: context),
                      ],
                    ),
                  ),
                ],
              );
            default:
              return const Center(child: Text("Error inesperado"));
          }
        },
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

  Widget codBarrasGenerated(dynamic imageBytes) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      children: [
        Text("Ejemplar añadido correctamente",
            style: context.textTheme.bodyText1
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp)),
        Image.memory(imageBytes, height: 30.h, width: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Aceptar",
                    style: context.textTheme.bodyText1
                        ?.copyWith(color: Colors.white))),
          ],
        )
      ],
    );
  }
}
