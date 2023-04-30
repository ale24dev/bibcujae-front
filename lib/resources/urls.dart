class Urls {
  ///Api Version
  static const String version = "v1";

  ///Port
  static const String port = '8000';

  ///Interserver Development
  static const String host = 'http://localhost:$port';

  ///Interserver Development
  ///static const String hostApi = '$host/api/$version';
  static const String hostApi = '$host/api';

  ///Token provider
  static String get login => '$auth/login';

  ///Auth Services
  static String auth = "$hostApi/auth";
  static String get logout => '$auth/logout';
  static String get updateUserByUsername => '$auth/update';

  ///Document Services
  static String document = "$hostApi/document";

  ///Books services
  static String get getAllBooks => '$document/book/all';
  static String get createBook => '$document/book/create';
  static String get donwloadBookReport => '$document/book/writeInExcel/';

  ///Ejemplares services
  static String get getEjemplaresOfBook => '$document/ejemplar/libro';
  static String get createEjemplarToBook => '$document/ejemplar/create';
  static String get deleteEjemplar => '$document/ejemplar';
}
