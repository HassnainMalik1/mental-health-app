import 'package:flutter/material.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';
import 'package:mental_health_care/core/theme/custom_text.dart';
import 'package:typewritertext/typewritertext.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalDarkColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              CustomText.brand_name1,
              style: TextStyle(
                  color: AppColors.mentalBrandColor,
                  fontSize: 32.0,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              width: 8.0,
            ),
            TypeWriterText(
              text: Text(
                CustomText.brand_name2,
                style: TextStyle(
                    color: AppColors.mentalBrandLightColor,
                    fontSize: 32.0,
                    fontWeight: FontWeight.normal),
              ),
              duration: Duration(milliseconds: 400),
            ),
          ],
        ),
      ),
    );
  }
}
