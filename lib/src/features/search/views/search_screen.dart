import 'package:bibcujae/src/entities/book_page_entity.dart';
import 'package:bibcujae/src/features/book/widgets/book_table.dart';
import 'package:bibcujae/src/features/book/widgets/book_table_data_source.dart';
import 'package:bibcujae/src/features/search/widgets/section_filters.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:bibcujae/src/shared/widgets/generic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../resources/general_styles.dart';
import '../../../shared/constants/constants.dart';
import '../cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

String dropdownOptionsValue = 'es igual a';

String dropdownRulesValue = 'Título';

List<String> listRules = [
  "Título",
  "Autor",
  "Dewey",
  "ISBN",
  "Materia",
  "Año de Publicación",
  "Edición",
  "Serie",
  "Cod. Domicilio",
  "Colación",
  "Idioma",
  "Evento",
  "País",
];

List<String> listOptions = [
  "es igual a",
  "contiene",
  "entre",
  "antes de",
  "después de"
];

late TextEditingController valueController;
late BookDataSource bookDataSource;
late BookPageEntity bookPageEntity;

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    valueController = TextEditingController();
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        buildWhen: (oldState, newState) {
      return oldState != newState;
    }, builder: (context, state) {
      ///Limpiamos el valor para una nueva entrada
      valueController.clear();

      var cubit = context.read<SearchCubit>();

      switch (state.runtimeType) {
        case SearchLoading:
          return const Center(child: CircularProgressIndicator());
        case SearchError:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: GStyles.colorFail,
                content: Text(
                    (state as SearchError).apiResult.serverError.toString()),
              ),
            );
          });
          break;
        default:
      }
      return Container(
        decoration: BoxDecoration(
            color: GStyles.colorCrema,
            borderRadius: BorderRadius.circular(Constants.RADIO_BUTTONS)),
        child: Padding(
          padding: EdgeInsets.only(
              left: 10.sp, right: 10.sp, top: 10.sp, bottom: 10.sp),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(
                        Constants.RADIO_BUTTONS),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1.0,
                          spreadRadius: 4.0,
                          color: Colors.black.withOpacity(.02))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Nueva regla: ", style: context.textTheme.bodyText1),
                      SizedBox(width: 10.sp),
                      DropdownButton<String>(
                        menuMaxHeight: 20.h,
                        // Step 3.
                        focusColor: Colors.red,
                        value: dropdownRulesValue,
                        borderRadius:
                            BorderRadius.circular(Constants.RADIO_BUTTONS),
                        // Step 4.
                        items: listRules
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: context.textTheme.bodyText1,
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownRulesValue = newValue!;
                          });
                        },
                      ),
                      SizedBox(width: 5.w),
                      DropdownButton<String>(
                        menuMaxHeight: 20.h,
                        value: dropdownOptionsValue,
                        borderRadius:
                            BorderRadius.circular(Constants.RADIO_BUTTONS),
                        items: listOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: context.textTheme.bodyText1,
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownOptionsValue = newValue!;
                          });
                        },
                      ),
                      SizedBox(width: 5.w),
                      SizedBox(
                          width: 20.w,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // Add padding around the search bar
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                // Use a Material design search bar
                                child: TextField(
                                  style: context.textTheme.bodyText1
                                      ?.copyWith(color: Colors.black),
                                  controller: valueController,
                                  decoration: InputDecoration(
                                    hintText: '  Valor',
                                    // Add a clear button to the search bar
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () => valueController.clear(),
                                    ),
                                    // Add a search icon or button to the search bar
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ))),
                      SizedBox(width: 5.w),
                      GenericButton(
                        callbackFunction: () {
                          context.read<SearchCubit>().addNewRule(
                              category: dropdownRulesValue,
                              option: dropdownOptionsValue,
                              value: valueController.text);
                        },
                        text: "Añadir regla",
                      )
                    ],
                  ),
                ),
              ),
              //Divider(color: Colors.black),
              /**
               * *Sección de filtros
               */
              SectionFilters(cubit: cubit),
              // if (state is SearchEmpty)
              //   Center(
              //       child: Text("No se encontraron resultados",
              //           style: context.textTheme.bodyText1)),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                  if (state is SearchLoaded) {
                    bookDataSource = BookDataSource(
                        listBooksBaseModel:
                            state.apiResult.responseObject.results);
                    bookPageEntity = state.apiResult.responseObject;
                    return BookTable(
                        isFromSearch: true,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(
                                Constants.RADIO_BUTTONS),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1.0,
                                  spreadRadius: 4.0,
                                  color: Colors.black.withOpacity(.02))
                            ]),
                        bookPageEntity: bookPageEntity,
                        bookDataSource: bookDataSource);
                  }
                  switch (state.runtimeType) {
                    case SearchLoading:
                      return const Center(child: CircularProgressIndicator());

                    case SearchEmpty:
                      return Center(
                          child: Text("No se encontraron resultados",
                              style: context.textTheme.bodyText1));

                    default:
                  }

                  return Center(
                      child: Text("No se encontraron resultados",
                          style: context.textTheme.bodyText1));
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}



// Widget selectCategory(BuildContext context, SearchCubit cubit) {
//   return TypeAheadField(
//     //hideKeyboard: true,
//     textFieldConfiguration: TextFieldConfiguration(
//       enableSuggestions: false,
//       cursorColor: const Color.fromARGB(0, 255, 255, 255),
//       autofocus: false,
//       decoration: InputDecoration(
//           contentPadding: const EdgeInsets.only(left: 10.0),
//           /**
//            * *Se le da un espacio para que desaparezca el cursor
//            */
//           hintText: " ${cubit.state.categorySelected}",
//           hintStyle:
//               context.textTheme.bodyText1?.copyWith(color: Colors.black54),
//           suffixIcon: Icon(
//             Icons.keyboard_arrow_down,
//             color: GStyles.colorSecondary,
//           ),
//           suffixIconColor: GStyles.colorSecondary,
//           focusColor: GStyles.colorSecondary,
//           hoverColor: GStyles.colorSecondary,
//           border: OutlineInputBorder(
//               borderSide: BorderSide(color: GStyles.colorSecondary)),
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: GStyles.colorSecondary)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: GStyles.colorSecondary))),
//     ),
//     suggestionsCallback: (pattern) async {
//       return cubit.state.listCategories.where((String category) {
//         return category.toLowerCase().contains(pattern.toLowerCase());
//       });
//     },
//     itemBuilder: (context, String suggestion) {
//       return Padding(
//         padding: EdgeInsets.all(15.sp),
//         child: Row(
//           children: [
//             Text(suggestion,
//                 style: context.textTheme.bodyText1
//                     ?.copyWith(color: Colors.black54)),
//           ],
//         ),
//       );
//     },
//     onSuggestionSelected: (String suggestion) {
//       cubit.selectCategory(suggestion);
//     },
//   );
// }
