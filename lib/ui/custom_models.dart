import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';
import 'package:mental_health_care/core/theme/custom_text.dart';
import 'package:mental_health_care/ui/custom_button.dart';
import 'package:mental_health_care/ui/custom_text.dart';
import 'package:mental_health_care/ui/spacing.dart';

void customBottomSheet(
    {required BuildContext context,
    required String title,
    required Widget content,
    required VoidCallback onPressed}) {
  showModalBottomSheet(
      context: context,
      builder: (contextModel) {
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: CustomSpacing.kHorizontalPad),
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
              maxWidth: MediaQuery.of(context).size.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  height: 4.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: AppColors.mentalOnboardingTextColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              customSizeBox(context: contextModel, size: 0.04),
              mainHeading(
                  text: CustomText.mentalModelCheckEmailText,
                  context: contextModel),
              customSizeBox(context: contextModel, size: 0.01),
              subHeadingTextLarge(
                  text: CustomText.mentalModelCheckEmailSubText,
                  context: context),
              customSizeBox(context: contextModel, size: 0.05),
              CustomButton(
                  onPressed: () {},
                  buttonText: CustomText.mentalModelCheckEmailBtnText),
              customSizeBox(context: contextModel, size: 0.01),
              CustomButton(
                onPressed: () => Navigator.of(contextModel).pop(),
                buttonText: CustomText.mentalModelCheckCloseBtnText,
                btnColor: AppColors.mentalBrandLightColor,
                textColor: AppColors.mentalBrandColor,
              )
            ],
          ),
        );
      });
}

Widget showSpinner() {
  return Container(
    child: Center(
        child: SpinKitDualRing(
      color: AppColors.mentalBrandColor,
      size: 50.0,
    )),
  );
}
