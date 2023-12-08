import 'package:flutter/material.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.borderColor,
    this.buttonColor,
    required this.buttonText,
    required this.buttonTextStyle,
    this.buttonHeight,
    this.prefixImageName,
    this.onTap,
    this.iconForButton,
  });
  final Color? borderColor;
  final Color? buttonColor;
  final String buttonText;
  final TextStyle buttonTextStyle;
  final double? buttonHeight;
  final String? prefixImageName;
  final void Function()? onTap;
  final IconData? iconForButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: buttonHeight ?? ScreenUtils.height * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: borderColor ?? AppColors.white,
          ),
          color: buttonColor,
          borderRadius: BorderRadius.circular(
            40.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: prefixImageName != null,
              child: Image.asset(
                prefixImageName ?? '',
                height: ScreenUtils.height * 0.05,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: prefixImageName != null ? 10.0 : 0.0,
              ),
              child: Row(
                children: [
                  Visibility(
                    visible: iconForButton != null,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 5.0,
                      ),
                      child: Icon(iconForButton),
                    ),
                  ),
                  Text(
                    buttonText,
                    style: buttonTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
