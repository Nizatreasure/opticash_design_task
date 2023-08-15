import 'package:design_task/screens/authentication/sign_in/sign_in.dart';
import 'package:design_task/screens/authentication/sign_up/sign_up.dart';
import 'package:design_task/screens/onboarding/onboarding_page.dart';
import 'package:design_task/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case OnboardingPage.routeName:
      return MaterialPageRoute(builder: (_) => const OnboardingPage());

    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    case SignInScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SignInScreen());

    default:
      return errorRoute();
  }
}

MaterialPageRoute errorRoute() {
  return MaterialPageRoute(
    builder: ((context) => const Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Route does not exist or route has not been registered.',
              ),
            ),
          ),
        )),
  );
}
