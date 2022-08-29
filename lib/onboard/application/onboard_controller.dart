import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_care/routes/app_pages.dart';

class OnBoardingController extends GetxController {
  late PageController pageController;

  @override
  void onReady() {
    pageController = PageController(initialPage: 0);
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  nextPage() {
    if (pageController.page == 2) {
      Get.offAllNamed('/login');
    } else {
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }
}
