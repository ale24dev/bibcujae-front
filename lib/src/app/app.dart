import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/features/book/cubit/ejemplar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../features/auth/cubit/auth_cubit.dart';
import '../router/router.dart';
import '../../resources/themes.dart';
import '../shared/constants/constants.dart';
import '../features/home/cubit/drawer_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthCubit(),
          ),
          RepositoryProvider(
            create: (context) => DrawerCubit(),
          ),
          RepositoryProvider(
            create: (context) => BookCubit(),
          ),
          RepositoryProvider(
            create: (context) => EjemplarCubit(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          title: Constants.NAMEAPP,
          theme: Themes.lightTheme,
        ),
      );
    });
  }
}
