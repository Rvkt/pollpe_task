import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../core/theme/app_palette.dart';
class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;

    final Color effectiveBackgroundColor = backgroundColor ?? AppPalette.accentColor;
    final Color effectiveLabelColor = textColor ?? AppPalette.whiteColor;

    double h1 = width * 0.04;
    double bodyText = width * 0.045;
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: effectiveLabelColor,
                fontSize: h1,
                fontFamily: 'VarelaRound',
                // letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
