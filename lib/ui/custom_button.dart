import 'package:flutter/material.dart';

import 'package:mental_health_care/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? btnColor;
  final Color? textColor;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.btnColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: btnColor ??  AppColors.mentalBrandColor),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20.0,
                color: textColor ?? AppColors.mentalBrandLightColor),
          ),
        ),
      ),
    );
  }
}

class CustomCircleBtn extends StatelessWidget {
  final String imgName;
  final VoidCallback onPressed;
  final double radius;
  final double backgroundRadius;
  const CustomCircleBtn(
      {Key? key,
      required this.imgName,
      required this.onPressed,
      required this.radius,
      required this.backgroundRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 15.0),
      child: GestureDetector(
        onTap: onPressed,
        child: CircleAvatar(
          radius: backgroundRadius,
          backgroundColor: AppColors.mentalBrandColor,
          child: CircleAvatar(
            backgroundColor: AppColors.mentalBrandLightColor,
            radius: radius,
            child: Image.asset(
              'assets/images/$imgName.png',
              fit: BoxFit.cover,
              color: AppColors.mentalBrandColor,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}
