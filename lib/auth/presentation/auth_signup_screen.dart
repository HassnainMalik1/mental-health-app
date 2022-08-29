import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';
import 'package:mental_health_care/core/theme/brand_images.dart';
import 'package:mental_health_care/core/theme/custom_text.dart';
import 'package:mental_health_care/routes/app_routes.dart';
import 'package:mental_health_care/ui/custom_input_field.dart';
import 'package:mental_health_care/ui/custom_models.dart';
import 'package:mental_health_care/ui/custom_text.dart';
import 'package:mental_health_care/ui/spacing.dart';
import 'package:mental_health_care/utils/extensions_utils.dart';
import 'package:mental_health_care/utils/focus_helper.dart';

import '../../ui/custom_button.dart';
import '../application/auth_controller.dart';

class AuthSignupScreen extends StatefulWidget {
  const AuthSignupScreen({Key? key}) : super(key: key);

  @override
  State<AuthSignupScreen> createState() => _AuthSignupScreenState();
}

class _AuthSignupScreenState extends State<AuthSignupScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  final AuthController authController = Get.put(AuthController());

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
              mainHeading(text: CustomText.mentalSignUpText, context: context),
              Obx(() => authController.disableSignUpButton.value
                  ? showSpinner()
                  : Container()),
              customSizeBox(context: context, size: 0.04),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomInputField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isValidEmail == false) {
                            return CustomErrorText.invalidEmail;
                          }
                          return null;
                        },
                      ),
                      CustomInputPassword(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscuringCharacter: "*",
                        validator: (String? value) {
                          if (value!.isValidPassword == false) {
                            return CustomErrorText.invalidPassword;
                          }
                          return null;
                        },
                      ),
                      customSizeBox(context: context, size: 0.12),
                      Obx(
                        () => AbsorbPointer(
                          absorbing: authController.disableSignUpButton.value,
                          child: CustomButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  authController.registerWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              buttonText: CustomText.mentalSignUpText),
                        ),
                      ),
                      customSizeBox(context: context, size: 0.13),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CustomText.mentalSocialSignUpText,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomCircleBtn(
                                  imgName: BrandImages.kGoogleIconName,
                                  radius: 19.0,
                                  backgroundRadius: 20,
                                  onPressed: () {
                                    authController.googleSignIn();
                                  }),
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
                            CustomText.mentalSignUpAlreadyAccountText,
                            style: Theme.of(context).textTheme.button,
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Text(
                              CustomText.mentalSignInText,
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
