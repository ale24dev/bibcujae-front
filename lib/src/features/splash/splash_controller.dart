import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SplashController {
  static checkLogin(BuildContext context) {
    initData(context);
  }

  static initData(BuildContext context) {
    ///Inicializamos la lista de libros
    context.read<BookCubit>().loadBooks();
  }
}
