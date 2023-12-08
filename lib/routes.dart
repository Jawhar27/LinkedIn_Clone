import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_clone/presentation/pages/home/home_screen.dart';
import 'package:linkedin_clone/presentation/pages/main_screen.dart';
import 'package:linkedin_clone/presentation/pages/onboard_slider/onboard_screen.dart';
import 'package:linkedin_clone/presentation/pages/profile/profile_screen.dart';
import 'package:linkedin_clone/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:linkedin_clone/presentation/pages/sign_up/sign_up_screen.dart';
import 'package:linkedin_clone/presentation/pages/splash_screen.dart';

class ScreenRoutes {
  static const String toSplashScreen = "toSplashScreen";
  static const String toSignInScreen = "toSignInScreen";
  static const String toSignUpScreen = "toSignUpScreen";
  static const String toHomeScreen = "toHomeScreen";
  static const String toSliderScreen = "toSliderScreen";
  static const String toMainScreen = "toMainScreen";
  static const String toProfileScreen = "toProfileScreen";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.toSplashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case ScreenRoutes.toSignInScreen:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );
      case ScreenRoutes.toSignUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: settings,
        );
      case ScreenRoutes.toHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreeen(),
          settings: settings,
        );
      case ScreenRoutes.toSliderScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
          settings: settings,
        );
      case ScreenRoutes.toMainScreen:
        var data = (settings.arguments ?? {}) as Map;
        User? user = data['authUser'];
        return MaterialPageRoute(
          builder: (_) => MainScreen(
            user: user,
          ),
          settings: settings,
        );
      case ScreenRoutes.toProfileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
