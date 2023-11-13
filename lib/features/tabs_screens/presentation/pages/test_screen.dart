import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/features/tabs_screens/data/datasources/remote.dart';
import 'package:quotes/features/tabs_screens/presentation/cubit/tabs_screens_cubit.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TabsScreensCubit(RemoteDto())..getQuotesData(),
      child: BlocConsumer<TabsScreensCubit, TabsScreensState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                child: state is TabsScreensGetDataRemoteSuccessState
                    ? Image.network(state.quotes[0].image!.largeImageUrl ?? '')
                    : state is TabsScreensGetDataRemoteFailureState
                        ? Text(state.failures.toString())
                        : CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
