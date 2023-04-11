import '../models/book_base_model.dart';

class BookPageEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<BookBaseModel> results;

  const BookPageEntity(
      {required this.count,
      required this.next,
      required this.previous,
      required this.results});
}
