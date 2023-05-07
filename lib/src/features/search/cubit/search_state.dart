part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchEmpty extends SearchState {
  const SearchEmpty();
}

class SearchCategorySelected extends SearchState {
  const SearchCategorySelected();
}

class SearchLoaded extends SearchState {
  final ApiResult apiResult;

  const SearchLoaded({required this.apiResult});
}

class SearchError extends SearchState {
  final ApiResult apiResult;

  const SearchError({required this.apiResult});
}
