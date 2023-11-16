import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/functions/lumination.dart';
import 'package:quotes/core/utils/text_styles.dart';

toastMessage(String message, {Icon? icon, Color? color}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color?.withOpacity(.5) ?? AppColors.primaryColor.withOpacity(.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon ?? Container(),
        SizedBox(
          width: icon == null ? 0 : 12.0,
        ),
        Text(
          message,
          style: poppins18W400().copyWith(
              color: calculateLuminance() ? Colors.black : Colors.white),
        ),
      ],
    ),
  );
}
