import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/business_logic/blocs/authentication_bloc.dart';
import 'package:linkedin_clone/presentation/utils/navigation_util.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';
import 'package:linkedin_clone/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
    // GETTING SCREEN DETAILS
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenUtils.mqData = MediaQuery.of(context);
      ScreenUtils.screenSize = MediaQuery.of(context).size;
    });
  }

  void _navigateToRelavantScreen(String routeName) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      moveToScreen(
        context,
        routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: context.read(),
        builder: (context, state) {
          if (state is Uninitialized) {
            printLogs(
                '******* UNINITIALIZED ----> NAVIGATING TO ONBOARD SCREEN ***********');
            _navigateToRelavantScreen(
              ScreenRoutes.toSliderScreen,
            );
          }
          if (state is Authenticated) {
            printLogs(
                '******* AUTHENTICATED ----> NAVIGATING TO HOME SCREEN ***********');
            _navigateToRelavantScreen(
              ScreenRoutes.toMainScreen,
            );
          }
          if (state is Unauthenticated) {
            printLogs(
                '******* UNAUTHENTICATED ----> NAVIGATING TO SLIDER SCREEN ***********');
            _navigateToRelavantScreen(
              ScreenRoutes.toSliderScreen,
            );
          }

          return Center(
            child: Image.asset(
              splashLogo,
              height: size.height * 0.5,
              width: size.width * 0.5,
            ),
          );
        },
      ),
    );
  }
}
