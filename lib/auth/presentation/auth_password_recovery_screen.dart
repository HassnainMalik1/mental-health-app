import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';
import 'package:mental_health_care/core/theme/brand_images.dart';
import 'package:mental_health_care/core/theme/custom_text.dart';
import 'package:mental_health_care/ui/custom_button.dart';
import 'package:mental_health_care/ui/custom_input_field.dart';
import 'package:mental_health_care/ui/custom_models.dart';
import 'package:mental_health_care/ui/custom_text.dart';
import 'package:mental_health_care/ui/spacing.dart';
import 'package:mental_health_care/utils/focus_helper.dart';

class AuthPasswordRecoveryScreen extends StatefulWidget {
  const AuthPasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<AuthPasswordRecoveryScreen> createState() =>
      _AuthPasswordRecoveryScreenState();
}

class _AuthPasswordRecoveryScreenState
    extends State<AuthPasswordRecoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context: context);
      },
      child: Scaffold(
        backgroundColor: AppColors.mentalBrandLightColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: CustomSpacing.kHorizontalPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.close,
                  size: 25.0,
                ),
              ),
              customSizeBox(context: context, size: 0.15),
              mainHeading(
                  text: CustomText.mentalPasswordRecoveryText,
                  context: context),
              customSizeBox(context: context, size: 0.02),
              subHeadingTextLarge(
                  text: CustomText.mentalPasswordResetSubText,
                  context: context),
              customSizeBox(context: context, size: 0.05),
              Form(
                  child: Column(
                children: [
                  CustomInputField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return CustomErrorText.invalidEmail;
                      } else {
                        return null;
                      }
                    },
                  ),
                  customSizeBox(context: context, size: 0.12),
                  CustomButton(
                      onPressed: () {
                        customBottomSheet(
                          content: Text('Hello model'),
                            context: context,
                            title: 'Here is model',
                            onPressed: () {});
                      },
                      buttonText: CustomText.mentalPasswordSendBtnText),
                  customSizeBox(context: context, size: 0.25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        CustomText.mentalPasswordResetBottomText,
                        style: Theme.of(context).textTheme.button,
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          CustomText.mentalPasswordResetReturnText,
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: AppColors.mentalBrandColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ))),
      ),
    );
  }
}
