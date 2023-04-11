import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/features/home/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class SplashController {
  static checkLogin(BuildContext context) {
    // context.read<DrawerCubit>().emit(state)
    initData(context);
    //context.go("/home");
  }

  static initData(BuildContext context) {
    ///Inicializamos la lista de libros
    context.read<BookCubit>().loadBooks();
  }
}
