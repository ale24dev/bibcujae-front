import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

  static BookBaseModel? getBookById(BuildContext context, int id) {
    if (context.read<BookCubit>().listBooks != null) {
      List<BookBaseModel> listBooks = context.read<BookCubit>().listBooks!;
      return listBooks.firstWhere((book) => book.bookId == id);
    }
    return null;
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
}
