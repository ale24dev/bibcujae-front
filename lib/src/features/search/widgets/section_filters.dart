import 'package:bibcujae/resources/general_styles.dart';
import 'package:bibcujae/src/entities/search_filter_entity.dart';
import 'package:bibcujae/src/features/search/cubit/search_cubit.dart';
import 'package:bibcujae/src/shared/constants/constants.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:bibcujae/src/shared/utils.dart';
import 'package:bibcujae/src/shared/widgets/generic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SectionFilters extends StatelessWidget {
  const SectionFilters({
    super.key,
    required this.cubit,
  });

  final SearchCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      margin: EdgeInsets.only(top: 5.sp, bottom: 1.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.circular(Constants.RADIO_BUTTONS),
          boxShadow: [
            BoxShadow(
                blurRadius: 1.0,
                spreadRadius: 4.0,
                color: Colors.black.withOpacity(.02))
          ]),
      child: cubit.listCategories != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ListView.builder(
                      itemCount: cubit.listCategories!.length,
                      itemBuilder: ((_, index) {
                        SearchFilter searchFilter =
                            cubit.listCategories![index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.sp),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<SearchCubit>().removeRule(
                                          category: searchFilter.category,
                                          option: searchFilter.option.name,
                                          value: searchFilter.value);
                                    },
                                    child: Icon(Icons.remove_circle,
                                        color: GStyles.colorFail),
                                  ),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    width: 15.w,
                                    child: Text(searchFilter.category,
                                        style: context.textTheme.bodyText1),
                                  ),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    width: 15.w,
                                    child: Text(
                                        Utils.getTextBySearchFilterOptionEnum(
                                            searchFilter.option),
                                        style: context.textTheme.bodyText1),
                                  ),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    width: 15.w,
                                    child: Text(searchFilter.value,
                                        style: context.textTheme.bodyText1),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[100]),
                          ],
                        );
                      })),
                  Positioned(
                    bottom: 10.sp,
                    right: 10.sp,
                    child: GenericButton(
                        text: "Aplicar filtros",
                        callbackFunction: () {
                          cubit.searchBooksByFilters();
                        }),
                  )
                ],
              ),
            )
          : Center(
              child: Text("Introduzca una regla de filtro",
                  style: context.textTheme.bodyText1)),
    );
  }
}
