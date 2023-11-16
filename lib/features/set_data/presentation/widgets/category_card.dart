import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/text_styles.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final bool opacity;
  final Function? delete;
  const CategoryCard({
    Key? key,
    required this.category,
    this.opacity = false,
    this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        delete != null
            ? Theme(
                data: ThemeData(splashColor: Colors.transparent),
                child: IconButton(
                  padding: EdgeInsets.only(left: 0, right: 10.w, bottom: 10.h),
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    delete!();
                  },
                  icon: Padding(
                    padding:
                        EdgeInsets.only(left: 0, right: 10.w, bottom: 10.h),
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 25.r,
                      color: opacity
                          ? AppColors.blackColor.withOpacity(.3)
                          : AppColors.blackColor,
                    ),
                  ),
                ),
              )
            : Container(),
        Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          decoration: BoxDecoration(
              border: Border.all(
                  color: opacity
                      ? AppColors.blackColor.withOpacity(.2)
                      : AppColors.blackColor),
              color: opacity
                  ? AppColors.greyColor.withOpacity(.2).withOpacity(.2)
                  : AppColors.greyColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(15.r)),
          child: Text(
            category,
            style: opacity
                ? poppins20W400()
                    .copyWith(color: AppColors.blackColor.withOpacity(.4))
                : poppins20W400(),
          ),
        ),
      ],
    );
  }
}
