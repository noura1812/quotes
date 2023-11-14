import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/routes/app_routs.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/functions/lumination.dart';
import 'package:quotes/core/utils/text_styles.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/tabs_screens/presentation/cubit/tabs_screens_cubit.dart';

class HomeLayOut extends StatelessWidget {
  const HomeLayOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TabsScreensCubit()..getUsersData(),
      child: BlocConsumer<TabsScreensCubit, TabsScreensState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                title: Text(
                  'Hello ${TabsScreensCubit.get(context).usersDataModel?.name},',
                  style: poppins22W600().copyWith(
                    color: calculateLuminance() ? Colors.black : Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        UsersDataModel? user =
                            TabsScreensCubit.get(context).usersDataModel;

                        Navigator.pushNamed(context, Routes.settingsScreen,
                                arguments: user)
                            .then((value) {
                          if (value != null) {
                            TabsScreensCubit.get(context)
                                .changeSettings(value as UsersDataModel);
                          }
                        });
                      },
                      icon: Icon(
                        Icons.settings,
                        color:
                            calculateLuminance() ? Colors.black : Colors.white,
                      ))
                ],
              ),
              body: TabsScreensCubit.get(context).currentTab(),
              bottomNavigationBar: BottomAppBar(
                notchMargin: 8,
                child: BottomNavigationBar(
                    showUnselectedLabels: false,
                    showSelectedLabels: true,
                    unselectedItemColor: calculateLuminance()
                        ? Colors.black.withOpacity(.5)
                        : Colors.white.withOpacity(.5),
                    selectedItemColor:
                        calculateLuminance() ? Colors.black : Colors.white,
                    elevation: 0,
                    backgroundColor: AppColors.primaryColor,
                    iconSize: 25,
                    currentIndex: TabsScreensCubit.get(context).tab,
                    onTap: (value) {
                      TabsScreensCubit.get(context).changeTabs(value);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                          ),
                          label: 'Quotes'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.favorite,
                          ),
                          label: 'Favorite'),
                    ]),
              ));
        },
      ),
    );
  }
}
