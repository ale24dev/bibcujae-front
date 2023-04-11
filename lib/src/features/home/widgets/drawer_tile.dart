import 'package:flutter/material.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../resources/general_styles.dart';
import '../constants/drawer_items.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.index,
    required this.title,
    required this.isSelected,
  });

  final String title;

  final int index;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
                color:
                    isSelected ? GStyles.drawerSelectColor : GStyles.darkTheme,
                borderRadius: BorderRadius.circular(4.0)),
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                children: [
                  getIcon(index),
                  SizedBox(width: 10.sp),
                  Text(title,
                      style: context.textTheme.bodyText1
                          ?.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Icon getIcon(int index) {
    switch (index) {
      case 0:
        return const Icon(Icons.search, color: Colors.grey);
      case 1:
        return const Icon(Icons.menu_book_rounded, color: Colors.grey);
      case 2:
        return const Icon(Icons.personal_video_outlined, color: Colors.grey);
      default:
        return const Icon(Icons.bar_chart_sharp, color: Colors.grey);
    }
  }
}
