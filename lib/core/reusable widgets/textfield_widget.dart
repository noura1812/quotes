import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/utils/text_styles.dart';

typedef Validator = String? Function(String?);

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Icon? suffix;
  final Icon? prefix;
  final Validator? validator;
  final Function? onChange;
  const TextFieldWidget(
      {required this.title,
      required this.controller,
      super.key,
      this.onChange,
      this.suffix,
      this.prefix,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: poppins20W600(),
        ),
        SizedBox(
          height: 4.h,
        ),
        TextFormField(
          controller: controller,
          onChanged: (value) {
            onChange == null ? null : onChange!(value);
          },
          validator: validator,
          decoration: InputDecoration(
              suffixIcon: suffix,
              prefix: prefix,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.h),
              hintText: title,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              )),
        ),
      ],
    );
  }
}