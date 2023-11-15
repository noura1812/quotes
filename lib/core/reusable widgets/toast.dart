import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/functions/lumination.dart';

toastMessage(String message, {Color? color}) {
  return Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:
          color?.withOpacity(.5) ?? AppColors.primaryColor.withOpacity(.5),
      textColor: calculateLuminance() ? Colors.black : Colors.white,
      fontSize: 16.0);
}
