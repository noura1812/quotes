import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              appBar: AppBar(),
              body: TabsScreensCubit.get(context).currentTab(),
              bottomNavigationBar: BottomAppBar(
                notchMargin: 8,
                child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    iconSize: 25,
                    currentIndex: TabsScreensCubit.get(context).tab,
                    onTap: (value) {
                      TabsScreensCubit.get(context).changeTabs(value);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.list,
                          ),
                          label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.settings,
                          ),
                          label: ''),
                    ]),
              ));
        },
      ),
    );
  }
}
