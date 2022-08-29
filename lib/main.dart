import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mental_health_care/binding/main_binding.dart';
import 'package:mental_health_care/core/theme/mental_health_theme.dart';
import 'package:mental_health_care/firebase_options.dart';
import 'package:mental_health_care/routes/app_pages.dart';

import 'launchscreen/presentation/welcome_screen.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        initialBinding: MainBinding(),
        theme: mentalHealthThemeLight,
        darkTheme: mentalHealthThemeDark,
        themeMode: ThemeMode.system,
        home: const WelcomeScreen());
  }
}
