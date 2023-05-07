import 'package:bibcujae/locator.dart';
import 'package:bibcujae/src/entities/search_filter_entity.dart';
import 'package:bibcujae/src/repositories/book_repositories.dart';
import 'package:bibcujae/src/shared/repository/ApiResult.dart';
import 'package:bibcujae/src/shared/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  // final List<String> _listCategories = ["Materia", "Título", "ISBN", "Dewey"];

  ///Total de items por pagina
  final int ITEMS_BY_PAGE = 20;

  List<SearchFilter>? _listFilters;

  late SearchFilter _searchFilter;

  late String? _value;

  SearchFilter? get searchFilter => _searchFilter;

  String? get value => _value;

  // List<String> get listCategories => _listCategories;
  List<SearchFilter>? get listCategories => _listFilters;

  void addNewRule(
      {required String category,
      required String option,
      required String value}) {
    emit(const SearchLoading());

    if (value.isEmpty) {
      emit(SearchError(
          apiResult: ApiResult(serverError: "Debe ingresar un valor")));
    } else {
      ///Creamos la lista de no existir
      _listFilters ??= [];

      _searchFilter = SearchFilter(
          category: category,
          option: Utils.getSearchFilterOptionEnumByText(option),
          value: value);
      _listFilters!.add(_searchFilter);

      emit(const SearchInitial());
    }
  }

  void removeRule(
      {required String category,
      required String option,
      required String value}) {
    emit(const SearchLoading());
    _listFilters!.removeWhere((filter) =>
        filter.category == category &&
        filter.option.name == option &&
        filter.value == value);
    if (_listFilters!.isEmpty) {
      _listFilters = null;
    }

    emit(const SearchInitial());
  }

  void searchBooksByFilters({String? url}) async {
    if (_listFilters != null) {
      emit(const SearchLoading());
      ApiResult apiResult = await serviceLocator<BookRepository>()
          .searchBooksByFilters(
              searchFilters: _listFilters!, items: ITEMS_BY_PAGE, url: url);

      switch (apiResult.statusCode) {
        case 200:
          if (apiResult.responseObject.results.isEmpty) {
            emit(const SearchEmpty());
          } else {
            emit(SearchLoaded(apiResult: apiResult));
          }
          break;
        default:
          emit(SearchError(apiResult: apiResult));
          break;
      }
    }
  }
}
