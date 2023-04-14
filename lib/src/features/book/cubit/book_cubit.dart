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

  void loadBooks({String? url, PaginationBook? paginationBook}) async {
    emit(BookLoading());

    final ApiResult apiResult = await serviceLocator<BookRepository>()
        .getAllBooks(url: url, items: ITEMS_BY_PAGE);

    switch (apiResult.statusCode) {
      case 200:
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

    print(apiResult.statusCode);
    switch (apiResult.statusCode) {
      case 200:
        emit(BookCreated());
        break;

      default:
        emit(BookError(apiResult: apiResult));
    }
  }
}
