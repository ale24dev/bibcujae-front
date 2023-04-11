import 'package:bibcujae/src/repositories/book_repositories.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setUp() {
  ///Singleton of AuthRepository
  serviceLocator.registerSingleton<BookRepository>(BookRepository());
}
