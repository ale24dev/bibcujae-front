import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/features/book/widgets/book_table.dart';
import 'package:bibcujae/src/shared/constants/constants.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../entities/book_page_entity.dart';
import '../../../repositories/book_repositories.dart';
import '../constants/pagination.dart';
import '../widgets/book_table_data_source.dart';
import '../widgets/header_book_screen.dart';
import 'book_details_screen.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late BookDataSource bookDataSource;
  late BookPageEntity bookPageEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Constants.RADIO_BUTTONS)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            print(state);
            if (state is BookLoaded) {
              bookDataSource = BookDataSource(
                  listBooksBaseModel: state.apiResult.responseObject.results,
                  context: context);
              bookPageEntity = state.apiResult.responseObject;
            }
            switch (state.runtimeType) {
              case BookLoading:
                return const Center(child: CircularProgressIndicator());
              case BookCreated:
                context.read<BookCubit>().loadBooks();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: GStyles.colorPrimary,
                      content: const Text('Libro creado correctamente'),
                    ),
                  );
                  Navigator.pop(context);
                });
                return const Center(child: CircularProgressIndicator());
              case BookDeleted:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: GStyles.colorPrimary,
                      content: const Text('Libro eliminado correctamente'),
                    ),
                  );

                  ///Cerramos el dialog de eliminar ejemplar
                  Navigator.pop(context);
                  context.read<BookCubit>().loadBooks();
                });

                return const Center(child: CircularProgressIndicator());
              case BookLoaded:
                return BookTable(
                    bookPageEntity: bookPageEntity,
                    bookDataSource: bookDataSource);
              case BookError:
                return Center(
                    child: Text((state as BookError).apiResult.serverError ??
                        "Ha ocurrido un error inesperado"));
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
              style: context.textTheme.bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
            )));
  }
}
