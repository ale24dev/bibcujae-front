import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/entities/book_page_entity.dart';
import 'package:bibcujae/src/features/book/constants/pagination.dart';
import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/shared/constants/constants.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaginationFooterButtons extends StatelessWidget {
  const PaginationFooterButtons({
    super.key,
    required this.bookPageEntity,
  });

  final BookPageEntity bookPageEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: bookPageEntity.previous != null
                ? () {
                    context.read<BookCubit>().loadBooks(
                        url: bookPageEntity.previous,
                        paginationBook: PaginationBook.PREVIOUS);
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.all(4.5.sp),
              child: Container(
                  decoration: BoxDecoration(
                      color: bookPageEntity.previous != null
                          ? GStyles.colorPrimary
                          : Colors.grey,
                      borderRadius:
                          BorderRadius.circular(Constants.RADIO_BUTTONS)),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Text("Anterior",
                        style: context.textTheme.bodyText1
                            ?.copyWith(color: Colors.white)),
                  )),
            ),
          ),
          Text(
            "Página ${bookPageEntity.currentPage} de ${bookPageEntity.numPages}",
            style: context.textTheme.bodyText1
                ?.copyWith(color: Colors.black),
          ),
          InkWell(
            onTap: bookPageEntity.next != null
                ? () {
                    context.read<BookCubit>().loadBooks(
                        url: bookPageEntity.next,
                        paginationBook: PaginationBook.NEXT);
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.all(4.5.sp),
              child: Container(
                  decoration: BoxDecoration(
                      color: GStyles.colorPrimary,
                      borderRadius:
                          BorderRadius.circular(Constants.RADIO_BUTTONS)),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Text("Siguiente",
                        style: context.textTheme.bodyText1
                            ?.copyWith(color: Colors.white)),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
