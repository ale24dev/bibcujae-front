import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/models/book_base_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/cubit/auth_cubit.dart';
import '../features/auth/views/login_screen.dart';
import '../features/book/views/book_details_screen.dart';
import '../features/home/views/home_screen.dart';
import '../shared/not_found_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const SplashScreen(),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      // redirect: (context, state) {
      //   if (!context.read<AuthCubit>().isSigned) {
      //     return '/';
      //   } else {
      //     return null;
      //   }
      // },
    ),
    GoRoute(
        path: '/book',
        builder: (context, state) {
          try {
            BookBaseModel? bookBaseModel =
                context.read<BookCubit>().bookSelected;
            return bookBaseModel == null
                ? const NotFoundPage()
                : BookDetailsScreen(bookBaseModel: bookBaseModel);
          } catch (e) {
            return const NotFoundPage();
          }
        },
        redirect: (context, state) {
          if (!context.read<AuthCubit>().isSigned) {
            return '/';
          } else {
            return null;
          }
        })
  ],
);
