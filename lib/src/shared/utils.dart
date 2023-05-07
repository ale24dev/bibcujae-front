import 'package:bibcujae/locator.dart';
import 'package:bibcujae/src/entities/search_filter_entity.dart';
import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/features/search/constants/constants.dart';
import 'package:bibcujae/src/repositories/book_repositories.dart';
import 'package:bibcujae/src/shared/repository/ApiResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../models/book_base_model.dart';

abstract class Utils {
  static String createGetUrl(
      {required String baseUrl, required Map<String, dynamic> params}) {
    String url = '$baseUrl?${params.keys.first}=${params.values.first}';
    for (int i = 1; i < params.length; i++) {
      url += '&${params.keys.elementAt(i)}=${params.values.elementAt(i)}';
    }
    return url;
  }

  static Future<BookBaseModel?> getBookById(
      BuildContext context, int id) async {
    ApiResult apiResult = await serviceLocator<BookRepository>().getAllBooks();

    List<BookBaseModel> listBooks = apiResult.responseObject;
    print(listBooks.length);
    return listBooks.firstWhere((book) {
      return book.bookId == id;
    });
  }

  static String capitalize(String word) {
    return word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
  }

  static String getCurrentDate() {
    DateTime now = DateTime.now();
    DateTime fechaFormateada = DateTime(now.year, now.month, now.day, 0, 0, 0);
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaFormateada);

    return formattedDate;
  }

  static dynamic getEjemplarById(
      List<dynamic> ejemplarList, String ejemplarId) {
    print("AAAAAAAAAAAAA: " + ejemplarId);
    print("BBBBBBBBBBBBBB: " + ejemplarList.length.toString());
    for (var ejemplar in ejemplarList) {
      print("A: " + ejemplar.ejemplarId.toString());
      print("B: " + int.parse(ejemplarId).toString());
      if (ejemplar.ejemplarId == int.parse(ejemplarId)) {
        return ejemplar;
      }
    }
    return null;
  }

  static SearchFilterOption getSearchFilterOptionEnumByText(String text) {
    switch (text) {
      case "es igual a":
        return SearchFilterOption.exact;
      case "contiene":
        return SearchFilterOption.contains;
      case "entre":
        return SearchFilterOption.range;
      case "antes de":
        return SearchFilterOption.less_than;
      default:
        return SearchFilterOption.greater_than;
    }
  }

  static String getTextBySearchFilterOptionEnum(
      SearchFilterOption searchOption) {
    switch (searchOption) {
      case SearchFilterOption.exact:
        return "es igual a";
      case SearchFilterOption.contains:
        return "contiene";
      case SearchFilterOption.range:
        return "entre";
      case SearchFilterOption.less_than:
        return "antes de";
      default:
        return "después de";
    }
  }

  static Map<String, dynamic> generateParams(
      List<SearchFilter> listSearchFilters) {
    List<Map<String, String>> searchFilters = [];

    for (var sf in listSearchFilters) {
      Map<String, String> sfMap = {
        'category': parseParams(removeAccents(sf.category).toLowerCase()),
        'option': sf.option.name,
        'value': sf.value,
      };

      searchFilters.add(sfMap);
    }

    Map<String, dynamic> result = {
      'searchFilters': searchFilters,
    };

    return result;
  }

  static String parseParams(String text) {
    switch (text) {
      case "ano de publicacion":
        return "anno_pub";
      case "cod. domicilio":
        return "cod_domicilio";
      default:
        return text;
    }
  }

  static String removeAccents(String text) {
    text = text.replaceAll('á', 'a');
    text = text.replaceAll('é', 'e');
    text = text.replaceAll('í', 'i');
    text = text.replaceAll('ó', 'o');
    text = text.replaceAll('ú', 'u');
    text = text.replaceAll('ü', 'u');
    text = text.replaceAll('ñ', 'n');
    return text;
  }
}
