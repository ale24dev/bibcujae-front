part of 'drawer_cubit.dart';

class DrawerState extends Equatable {
  final DrawerItem drawerItem;
  final int index;

 const DrawerState(this.drawerItem, this.index);

  @override
  List<Object> get props => [drawerItem, index];
}
