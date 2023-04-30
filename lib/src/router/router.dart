import 'package:bibcujae/src/models/book_base_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/book/views/book_details_screen.dart';
import '../features/home/views/home_screen.dart';
import '../shared/not_found_page.dart';
import '../shared/utils.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const SplashScreen(),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
        path: '/book',
        builder: (context, state) {
          try {
            BookBaseModel? bookBaseModel =
                Utils.getBookById(context, int.parse(state.queryParams["idBook"]!));
            return bookBaseModel == null
                ? const NotFoundPage()
                : BookDetailsScreen(bookBaseModel: bookBaseModel);
          } catch (e) {
            return const NotFoundPage();
          }
        })
  ],
);
