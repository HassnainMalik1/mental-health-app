import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mental_health_care/auth/application/auth_controller.dart';

class MainHomePageScreen extends StatefulWidget {
  const MainHomePageScreen({Key? key}) : super(key: key);

  @override
  State<MainHomePageScreen> createState() => _MainHomePageScreenState();
}

class _MainHomePageScreenState extends State<MainHomePageScreen> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: Center(
        child: GestureDetector(
            onTap: () {
              _authController.signOut();
            },
            child: Text('Main HOme page')),
      )),
    );
  }
}
