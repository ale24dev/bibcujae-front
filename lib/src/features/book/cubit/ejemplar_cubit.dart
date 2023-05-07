import 'package:bibcujae/src/models/book_base_model.dart';
import 'package:bibcujae/src/repositories/ejemplar_repositories.dart';
import 'package:bibcujae/src/shared/repository/ApiResult.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../locator.dart';
import '../../../models/ejemplar_base_model.dart';

part 'ejemplar_state.dart';

class EjemplarCubit extends Cubit<EjemplarState> {
  late List<dynamic> listEjemplares;
  EjemplarCubit() : super(EjemplarInitial());

  void getEjemplaresByBook(BookBaseModel book) async {
    listEjemplares = [];
    emit(EjemplarLoading());

    ApiResult apiResult = await serviceLocator<EjemplarRepository>()
        .getEjemplaresOfBook(book.bookId!);
    switch (apiResult.statusCode) {
      case 200:
        if (apiResult.responseObject.isEmpty) {
          emit(EjemplarEmpty());
        } else {
          listEjemplares.addAll(apiResult.responseObject);
          emit(EjemplarLoaded(apiResult: apiResult));
        }
        break;
      default:
        emit(EjemplarError(apiResult: apiResult));
    }
  }

  void createEjemplar(EjemplarBaseModel ejemplarBaseModel) async {
    emit(EjemplarLoading());
    ApiResult apiResult = await serviceLocator<EjemplarRepository>()
        .createEjemplar(ejemplarBaseModel);
    switch (apiResult.statusCode) {
      case 200:
        emit(EjemplarCreated(apiResult: apiResult));
        break;
      default:
        emit(EjemplarError(apiResult: apiResult));
    }
  }

  void updateEjemplar(
      EjemplarBaseModel ejemplarBaseModel, String ejemplarId) async {
    emit(EjemplarLoading());
    ApiResult apiResult = await serviceLocator<EjemplarRepository>()
        .updateEjemplar(ejemplarBaseModel, ejemplarId);
    switch (apiResult.statusCode) {
      case 200:
        emit(EjemplarUpdated());
        break;
      default:
        emit(EjemplarError(apiResult: apiResult));
    }
  }

  void deleteEjemplar(String ejemplarId) async {
    emit(EjemplarLoading());
    ApiResult apiResult =
        await serviceLocator<EjemplarRepository>().deleteEjemplar(ejemplarId);
    switch (apiResult.statusCode) {
      case 200:
        emit(EjemplarDeleted());
        break;
      default:
        emit(EjemplarError(apiResult: apiResult));
    }
  }
}
