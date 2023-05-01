import 'package:bibcujae/src/repositories/book_repositories.dart';
import 'package:bibcujae/src/repositories/ejemplar_repositories.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setUp() {
  ///Singleton de BookRepository
  serviceLocator.registerSingleton<BookRepository>(BookRepository());
  
  ///Singleton de BookRepository
  serviceLocator.registerSingleton<EjemplarRepository>(EjemplarRepository());
}
