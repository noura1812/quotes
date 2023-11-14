import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';

bool calculateLuminance() {
  // Convert the color to RGB values.
  Color color = AppColors.primaryColor;
  int red = color.red;
  int green = color.green;
  int blue = color.blue;

  double luminance = (0.2126 * red + 0.7152 * green + 0.0722 * blue) / 255.0;

  return luminance > .5;
}
