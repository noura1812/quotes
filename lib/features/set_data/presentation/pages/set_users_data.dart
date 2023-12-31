import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/config/routes/app_routs.dart';
import 'package:quotes/core/reusable%20widgets/dotted_line.dart';
import 'package:quotes/core/reusable%20widgets/textfield_widget.dart';
import 'package:quotes/core/reusable%20widgets/toast.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/utils/text_styles.dart';
import 'package:quotes/features/set_data/data/datastores/local.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/set_data/presentation/cubit/set_data_cubit.dart';
import 'package:quotes/features/set_data/presentation/widgets/category_card.dart';
import 'package:quotes/features/set_data/presentation/widgets/chip.dart';
import 'package:quotes/features/set_data/presentation/widgets/pick_color.dart';

class SetUsersData extends StatelessWidget {
  final TextEditingController category = TextEditingController();
  SetUsersData({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var usersData =
        ModalRoute.of(context)!.settings.arguments as UsersDataModel?;

    return BlocProvider(
      create: (BuildContext context) =>
          SetDataCubit(LocalDto(), usersDataModel: usersData),
      child: BlocConsumer<SetDataCubit, SetDataState>(
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
            appBar: usersData == null
                ? null
                : AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 40.h,
                        )),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            usersData == null
                                ? SizedBox(
                                    height: 30.h,
                                  )
                                : Container(),
                            Form(
                              key: formKey,
                              child: TextFieldWidget(
                                controller: SetDataCubit.get(context).name,
                                title: AppStrings.name,
                                validator: (String? nameText) {
                                  if (nameText == null ||
                                      nameText.trim().isEmpty) {
                                    return 'pleas enter your name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Divider(
                                color: AppColors.greyColor,
                                thickness: 2,
                              ),
                            ),
                            TextFieldWidget(
                                controller: category,
                                title: AppStrings.category,
                                refresh: IconButton(
                                    onPressed: () {
                                      SetDataCubit.get(context).refresh();
                                    },
                                    icon: const Icon(Icons.refresh)),
                                onChange:
                                    SetDataCubit.get(context).searchCategories),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: SetDataCubit.get(context)
                                      .categoriesList
                                      .isEmpty
                                  ? 0.h
                                  : 60.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: SetDataCubit.get(context)
                                    .categoriesList
                                    .length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    SetDataCubit.get(context)
                                        .addCategory(index);
                                  },
                                  child: CategoryCard(
                                    category: SetDataCubit.get(context)
                                        .categoriesList[index],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: const DottedLine(
                                  height: 2, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 60.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: SetDataCubit.get(context)
                                        .usersCategory
                                        .isEmpty
                                    ? SetDataCubit.get(context)
                                        .defaultCategories
                                        .length
                                    : SetDataCubit.get(context)
                                        .usersCategory
                                        .length,
                                itemBuilder: (context, index) => CategoryCard(
                                  opacity: SetDataCubit.get(context)
                                      .usersCategory
                                      .isEmpty,
                                  category: SetDataCubit.get(context)
                                          .usersCategory
                                          .isEmpty
                                      ? SetDataCubit.get(context)
                                          .defaultCategories[index]
                                      : SetDataCubit.get(context)
                                          .usersCategory[index],
                                  delete: () {
                                    SetDataCubit.get(context)
                                        .deleteCategory(index);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Divider(
                                color: AppColors.greyColor,
                                thickness: 2,
                              ),
                            ),
                            SizedBox(
                              height: 300.h,
                              child: SingleChildScrollView(
                                  child: Wrap(
                                spacing: 15,
                                children: List<Widget>.generate(
                                  SetDataCubit.get(context).colorsList.length +
                                      1,
                                  (int index) {
                                    if (index ==
                                        SetDataCubit.get(context)
                                            .colorsList
                                            .length) {
                                      return ChipWidget(
                                        selected:
                                            SetDataCubit.get(context).selected,
                                        index: index,
                                        onSelected: () {
                                          pickColor(
                                              cubit:
                                                  BlocProvider.of<SetDataCubit>(
                                                      context),
                                              context: context,
                                              save: SetDataCubit.get(context)
                                                  .addColor,
                                              pickImage:
                                                  SetDataCubit.get(context)
                                                      .pickColor);
                                        },
                                        child: left(Text(
                                          '+',
                                          style: poppins30W400(),
                                        )),
                                      );
                                    }
                                    return ChipWidget(
                                      selected:
                                          SetDataCubit.get(context).selected,
                                      index: index,
                                      onSelected: () {
                                        SetDataCubit.get(context)
                                            .changeSelected(index);
                                      },
                                      child: right(SetDataCubit.get(context)
                                          .colorsList[index]),
                                    );
                                  },
                                ).toList(),
                              )),
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            SetDataCubit.get(context).setUsersData();
                            if (usersData == null) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.homeLayOut);
                            } else {
                              Navigator.pop(context,
                                  SetDataCubit.get(context).usersDataModel);
                            }
                          }
                        },
                        child: Text(
                          AppStrings.save,
                          style: poppins24W600().copyWith(
                              color: SetDataCubit.get(context).selectedColor()),
                        )),
                  ),
                ],
              ),
            ),
          ));
        },
        listener: (context, state) {
          if (state is SetUsersDataLoadingState) {
            showDialog(
              context: context,
              builder: (context) =>
                  const AlertDialog(content: CircularProgressIndicator()),
            );
          } else if (state is SetUsersDataSuccessState) {
            Navigator.pop(context);
          } else if (state is SetUsersDataFailureState) {
            Navigator.pop(context);

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 100.h,
                  ),
                  content: Text(
                    AppStrings.thereWasAnError,
                    style: poppins20W400(),
                    textAlign: TextAlign.center,
                  )),
            );

            if (state is SetUsersDataSuccessState) {
              toastMessage('Saved',
                  color: SetDataCubit.get(context).selectedColor());
            }
          }
        },
      ),
    );
  }
}
