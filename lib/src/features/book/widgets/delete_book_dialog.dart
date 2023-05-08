import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/features/book/cubit/book_cubit.dart';
import 'package:bibcujae/src/features/search/cubit/search_cubit.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget deleteBookDialog(
    {required BuildContext context, required String bookId}) {
  void popContextCallback(String text) {
    print("Ahora si");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchCubit>().searchBooksByFilters();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: GStyles.colorPrimary,
          content: Text(text),
        ),
      );
      context.pop();
      //Navigator.pop(context);
    });
  }

  return SimpleDialog(
    contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
    children: [
      Text("¿Seguro que desea eliminar este libro?",
          style: context.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 13.sp)),
      SizedBox(height: 20.sp),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Text("Cancelar",
                  style: context.textTheme.bodyText1
                      ?.copyWith(color: Colors.white))),
          SizedBox(width: 2.w),
          ElevatedButton(
              onPressed: () {
                context
                    .read<BookCubit>()
                    .deleteBook(bookId, popContextCallback);
              },
              child: Text("Aceptar",
                  style: context.textTheme.bodyText1
                      ?.copyWith(color: Colors.white))),
        ],
      )
    ],
  );
}
