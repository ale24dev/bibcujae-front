import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constants/constants.dart';
import '../../book/views/book_screen.dart';
import '../../search/views/search_screen.dart';
import '../../splash/splash_controller.dart';
import '../constants/drawer_items.dart';
import '../widgets/drawer.dart';
import '../cubit/drawer_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SplashController.initData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const DrawerSection(),
            Expanded(
              child: BlocBuilder<DrawerCubit, DrawerState>(
                builder: (context, state) {
                  switch (state.drawerItem) {
                    case DrawerItem.BOOKS:
                      return const BookScreen();

                    case DrawerItem.SEARCH:
                      return const SearchScreen();
                    default:
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Constants.RADIO_BUTTONS)),
                      );
                  }
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Constants.RADIO_BUTTONS)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
