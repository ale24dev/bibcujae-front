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

  void loadBooks({String? url, PaginationBook? paginationBook}) async {
    print(url ?? "NADA");
    listBooks = [];
    emit(BookLoading());

    final ApiResult apiResult = await serviceLocator<BookRepository>()
        .getBoksWithPag(url: url, items: ITEMS_BY_PAGE);

    switch (apiResult.statusCode) {
      case 200:
        listBooks!.addAll(apiResult.responseObject.results);
        emit(BookLoaded(apiResult: apiResult));
        break;

      default:
        emit(BookError(apiResult: apiResult));
    }
  }

  void createBook({required BookBaseModel bookBaseModel}) async {
    emit(BookLoading());

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

  void deleteBook(String bookId, Function popContextCallback) async {
    emit(BookLoading());

    final ApiResult apiResult =
        await serviceLocator<BookRepository>().deleteBook(bookId);

    print("ANTEES: " + apiResult.statusCode.toString());
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
