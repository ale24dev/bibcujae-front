part of 'book_cubit.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final ApiResult apiResult;

  const BookLoaded({required this.apiResult});
}

class BookError extends BookState {
  final ApiResult apiResult;

  const BookError({required this.apiResult});
}
