import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../constants/drawer_items.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
DrawerCubit() : super(const DrawerState(DrawerItem.SEARCH, 0));

  void getNavBarItem(DrawerItem drawerItem) {
    switch (drawerItem) {
      case DrawerItem.SEARCH:
        emit(const DrawerState(DrawerItem.SEARCH, 0));
        break;
      case DrawerItem.BOOKS:
        emit(const DrawerState(DrawerItem.BOOKS, 1));
        break;
      case DrawerItem.LOAN:
        emit(const DrawerState(DrawerItem.LOAN, 2));
        break;
      default:
        emit(const DrawerState(DrawerItem.STATS, 3));
        break;
    }
  }}
