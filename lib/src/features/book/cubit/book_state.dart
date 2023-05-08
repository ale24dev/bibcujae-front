part of 'book_cubit.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookCreated extends BookState {}

class BookUpdated extends BookState {}

class BookDeleted extends BookState {}
class BookLoaded extends BookState {

  const BookLoaded();
}

class BookError extends BookState {
  final ApiResult apiResult;

  const BookError({required this.apiResult});
}

