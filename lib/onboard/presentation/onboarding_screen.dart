import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';
import 'package:mental_health_care/core/theme/brand_images.dart';
import 'package:mental_health_care/core/theme/custom_text.dart';
import 'package:mental_health_care/onboard/application/onboard_controller.dart';
import 'package:mental_health_care/onboard/widgets/onboarding_templete.dart';
import 'package:mental_health_care/routes/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  OnBoardingController _controller = Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: PageView(
          controller: _controller.pageController,
          children: [
            OnboardingTemplete(
              controller: _controller,
              image: BrandImages.kOnboardScreen1Image,
              subTitle1: CustomText.onboardingScreen1Text1,
              subTitle2: CustomText.onboardingScreen1Text2,
              buttonText: CustomText.onboardingScreenBtn1,
              onPressed: _controller.nextPage,
              skipBtnPressed: () => Get.offAllNamed(Routes.LOGIN),
            ),
            OnboardingTemplete(
              controller: _controller,
              image: BrandImages.kOnboardScreen2Image,
              subTitle1: CustomText.onboardingScreen2Text1,
              subTitle2: CustomText.onboardingScreen2Text2,
              buttonText: CustomText.onboardingScreenBtn2,
              onPressed: _controller.nextPage,
              skipBtnPressed: () => Get.offAllNamed(Routes.LOGIN),
            ),
            OnboardingTemplete(
              controller: _controller,
              image: BrandImages.kOnboardScreen3Image,
              subTitle1: CustomText.onboardingScreen3Text1,
              subTitle2: CustomText.onboardingScreen3Text2,
              buttonText: CustomText.onboardingScreenBtn2,
              onPressed: _controller.nextPage,
              skipBtnPressed: () => Get.offAllNamed(Routes.LOGIN),
            ),
          ],
        ),
      ),
    );
  }
}
