import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mental_health_care/auth/presentation/auth_login_screen.dart';
import 'package:mental_health_care/auth/presentation/auth_password_recovery_screen.dart';
import 'package:mental_health_care/auth/presentation/auth_signup_screen.dart';
import 'package:mental_health_care/home/presentation/main_home_page_screen.dart';
import 'package:mental_health_care/launchscreen/presentation/welcome_screen.dart';
import 'package:mental_health_care/onboard/presentation/onboarding_screen.dart';
import 'package:mental_health_care/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: INITIAL, page: () => WelcomeScreen()),
    GetPage(name: Routes.ONBOARD, page: () => OnboardingScreen()),
    GetPage(name: Routes.LOGIN, page: () => AuthLoginScree()),
    GetPage(name: Routes.SIGNUP, page: () => AuthSignupScreen()),
    GetPage(
        name: Routes.FORGET_PASSWORD,
        page: () => AuthPasswordRecoveryScreen(),
        fullscreenDialog: true,
        transition: Transition.native,
        popGesture: true),

    GetPage(name: Routes.HOME, page: ()=> MainHomePageScreen()),   
  ];
}
