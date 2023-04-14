import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../locator.dart';
import '../constants/pagination.dart';
import '../../../shared/repository/ApiResult.dart';
import '../../../repositories/book_repositories.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  ///Indice de la paginación actual
  late int _indexPage;

  ///Indice de la paginación actual
  final int ITEMS_BY_PAGE = 20;

  int get indexPage => _indexPage;

  void loadBooks({String? url, PaginationBook? paginationBook}) async {
    emit(BookLoading());

    setPaginationIndex(paginationBook: paginationBook);

    final ApiResult apiResult = await serviceLocator<BookRepository>()
        .getAllBooks(url: url, items: ITEMS_BY_PAGE);

    print(apiResult.statusCode);
    switch (apiResult.statusCode) {
      case 200:
        emit(BookLoaded(apiResult: apiResult));
        break;

      default:
        emit(BookError(apiResult: apiResult));
    }
  }

  void setPaginationIndex({PaginationBook? paginationBook}) {
    if (paginationBook == null) {
      _indexPage = 1;
    } else if (paginationBook == PaginationBook.PREVIOUS) {
      _indexPage -= 1;
    } else {
      _indexPage += 1;
    }
  }
}
