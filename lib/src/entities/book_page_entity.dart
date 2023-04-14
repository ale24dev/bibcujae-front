import '../models/book_base_model.dart';

class BookPageEntity {
  final int count;
  final String? next;
  final String? previous;
  final int currentPage;
  final int numPages;
  final List<BookBaseModel> results;

  const BookPageEntity(
      {required this.count,
      required this.next,
      required this.currentPage,
      required this.numPages,
      required this.previous,
      required this.results});
}
