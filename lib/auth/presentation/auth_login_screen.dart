import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_care/auth/application/auth_controller.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';
import 'package:mental_health_care/core/theme/brand_images.dart';

import 'package:mental_health_care/core/theme/custom_text.dart';
import 'package:mental_health_care/routes/app_routes.dart';
import 'package:mental_health_care/ui/custom_button.dart';
import 'package:mental_health_care/ui/custom_input_field.dart';
import 'package:mental_health_care/ui/custom_text.dart';
import 'package:mental_health_care/ui/spacing.dart';
import 'package:mental_health_care/utils/focus_helper.dart';

class AuthLoginScree extends StatefulWidget {
  const AuthLoginScree({Key? key}) : super(key: key);

  @override
  State<AuthLoginScree> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScree> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final AuthController authController = Get.put(AuthController());

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              customSizeBox(context: context, size: 0.15),
              mainHeading(text: CustomText.mentalSignInText, context: context),
              customSizeBox(context: context, size: 0.02),
              Form(
                  key: formKey,
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
                      CustomInputPassword(
                        keyboardType: TextInputType.text,
                        obscuringCharacter: "*",
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return CustomErrorText.invalidPassword;
                          } else {
                            return null;
                          }
                        },
                      ),
                      customSizeBox(context: context, size: 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.FORGET_PASSWORD),
                            child: Text(
                              CustomText.forgetPasswordText,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.button,
                            ),
                          )
                        ],
                      ),
                      customSizeBox(context: context, size: 0.12),
                      CustomButton(
                          onPressed: () {
                            
                          },
                          buttonText: CustomText.mentalSignInText),
                      customSizeBox(context: context, size: 0.13),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CustomText.mentalSocialSignInText,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomCircleBtn(
                                  imgName: BrandImages.kGoogleIconName,
                                  radius: 19.0,
                                  backgroundRadius: 20,
                                  onPressed: () {}),
                              CustomCircleBtn(
                                  imgName: BrandImages.kFacebookIconName,
                                  radius: 19.0,
                                  backgroundRadius: 20,
                                  onPressed: () {}),
                              CustomCircleBtn(
                                  imgName: BrandImages.kAppleIconName,
                                  radius: 19.0,
                                  backgroundRadius: 20,
                                  onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                      customSizeBox(context: context, size: 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CustomText.mentalSingInNoAccountText,
                            style: Theme.of(context).textTheme.button,
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.SIGNUP),
                            child: Text(
                              CustomText.mentalSignUpText,
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(
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
