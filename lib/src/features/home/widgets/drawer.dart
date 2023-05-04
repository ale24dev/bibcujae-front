import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../auth/cubit/auth_cubit.dart';
import 'drawer_tile.dart';
import '../cubit/drawer_cubit.dart';
import '../constants/drawer_items.dart';
import '../../../shared/constants/constants.dart';
import '../../../../resources/general_styles.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> listDrawerSections = [
      "Búsqueda",
      "Libros",
      "Préstamos",
      "Estadísticas"
    ];

    final double WIDTH_DRAWER_SECTION = 15.w;

    final double MARGIN_DRAWER_SECTION = 1.w;

    return Container(
      width: WIDTH_DRAWER_SECTION,
      color: GStyles.darkTheme,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_DRAWER_SECTION),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(Constants.NAMEAPP,
                style:
                    context.textTheme.bodyText1?.copyWith(color: Colors.white)),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<DrawerCubit, DrawerState>(
                    builder: (context, state) {
                      var cubit = context.read<DrawerCubit>();
                      return ListView.builder(
                          itemCount: listDrawerSections.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    cubit.getNavBarItem(DrawerItem.SEARCH);
                                    break;
                                  case 1:
                                    cubit.getNavBarItem(DrawerItem.BOOKS);
                                    break;
                                  case 2:
                                    cubit.getNavBarItem(DrawerItem.LOAN);
                                    break;
                                  default:
                                    cubit.getNavBarItem(DrawerItem.STATS);
                                }
                              },
                              child: DrawerTile(
                                  title: listDrawerSections[index],
                                  index: index,
                                  isSelected: state.index == index),
                            );
                          }));
                    },
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: GStyles.drawerSelectColor),
                              onPressed: () {
                                context.read<AuthCubit>().logout(context);
                              },
                              child: state is AuthLoading
                                  ? Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: const CircularProgressIndicator(
                                          backgroundColor: Colors.white),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Text("Cerrar sesión",
                                          style: context.textTheme.bodyText1
                                              ?.copyWith(color: Colors.white)),
                                    )),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
