import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/utils/functions/firest_run.dart';
import 'package:quotes/features/set_data/presentation/pages/se_users_data.dart';
import 'package:quotes/features/tabs_screens/presentation/pages/home_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 2000,
        splash: Icons.format_quote_sharp,
        nextScreen: FutureBuilder(
          future: firstRun(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!) {
              return SetUsersData();
            } else {
              return const HomeLayOut();
            }
          },
        ),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 100.h,
        backgroundColor: Colors.white);
  }
}
