import 'package:bibcujae/src/entities/book_page_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../locator.dart';
import '../../../models/book_base_model.dart';
import '../constants/pagination.dart';
import '../../../shared/repository/ApiResult.dart';
import '../../../repositories/book_repositories.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  ///Total de items por pagina
  final int ITEMS_BY_PAGE = 20;

  List<BookBaseModel>? listBooks;

  BookBaseModel? _bookSelected;

  BookBaseModel? get bookSelected => _bookSelected;

  BookPageEntity? _bookPageEntity;

  BookPageEntity? get bookPageEntity => _bookPageEntity;

  void loadBooks(
      {String? url, PaginationBook? paginationBook, bool? fromError}) async {
    emit(BookLoading());

    ///Reseteamos la tabla con los ultimos valores ya que ocurrió un error
    if (fromError != null) {
      Future.delayed(const Duration(milliseconds: 200))
          .then((value) => emit(const BookLoaded()));
    } else {
      listBooks = [];

      final ApiResult apiResult = await serviceLocator<BookRepository>()
          .getBoksWithPag(url: url, items: ITEMS_BY_PAGE);

      switch (apiResult.statusCode) {
        case 200:
          _bookPageEntity = apiResult.responseObject;
          listBooks!.addAll(apiResult.responseObject.results);
          emit(const BookLoaded());
          break;

        default:
          emit(BookError(apiResult: apiResult));
      }
    }
  }

  void createBook({required BookBaseModel bookBaseModel}) async {
    emit(BookLoading());
    if (bookBaseModel.title == null) {
      emit(BookError(
          apiResult:
              ApiResult(serverError: "Debe llenar los campos requeridos")));
    } else {
      final ApiResult apiResult =
          await serviceLocator<BookRepository>().createBook(bookBaseModel);

      switch (apiResult.statusCode) {
        case 200:
          emit(BookCreated());
          break;

        default:
          emit(BookError(apiResult: apiResult));
      }
    }
  }

  void deleteBook(String bookId, Function popContextCallback) async {
    emit(BookLoading());

    final ApiResult apiResult =
        await serviceLocator<BookRepository>().deleteBook(bookId);

    switch (apiResult.statusCode) {
      case 200:
        print("LLEGUE");
        popContextCallback("Libro eliminado correctamente");

        emit(BookDeleted());
        break;

      default:
        emit(BookError(apiResult: apiResult));
    }
  }

  void selectBook(BookBaseModel? bookSelected) {
    _bookSelected = bookSelected;
  }

  void updateBook(
      {required BookBaseModel bookBaseModel,
      required String bookId,
      required Function popContextCallback}) async {
    emit(BookLoading());

    final ApiResult apiResult = await serviceLocator<BookRepository>()
        .updateBook(bookBaseModel, bookId);

    switch (apiResult.statusCode) {
      case 200:
        popContextCallback("Libro actualizado correctamente");
        emit(BookUpdated());
        break;

      default:
        emit(BookError(apiResult: apiResult));
    }
  }
}
