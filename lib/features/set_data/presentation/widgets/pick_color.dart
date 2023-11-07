import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:quotes/core/utils/text_styles.dart';
import 'package:quotes/features/set_data/presentation/cubit/set_data_cubit.dart';

pickColor(
    {required context,
    required Function save,
    required Function pickImage,
    required cubit}) {
  Color pickerColor = const Color(0xff443a49);

  return showDialog(
    context: context,
    builder: (context) => BlocConsumer<SetDataCubit, SetDataState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            'Pick a color!',
            style: poppins20W600().copyWith(color: pickerColor),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                pickerColor = color;
                pickImage();
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'done',
                style: poppins20W600().copyWith(color: pickerColor),
              ),
              onPressed: () {
                save(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ),
  );
}
