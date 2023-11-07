// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipWidget extends StatelessWidget {
  final Either<Widget, Color> child;
  final int index;
  final int selected;

  final Function onSelected;
  const ChipWidget({
    Key? key,
    required this.child,
    required this.index,
    required this.onSelected,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: ChoiceChip(
        labelPadding: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        label: CircleAvatar(
          backgroundColor: child.fold((l) => Colors.white, (r) => r),
          radius: selected == index ? 33.r : 25.r,
          child: child.fold((l) => l, (r) => null),
        ),
        selected: selected == index,
        elevation: selected == index ? 15 : 6,
        backgroundColor: Colors.transparent,
        onSelected: (bool selected) {
          onSelected();
        },
      ),
    );
  }
}
