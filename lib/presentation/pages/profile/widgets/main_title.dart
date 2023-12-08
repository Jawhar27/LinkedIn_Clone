import 'package:flutter/material.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/presentation/common_widgets/main_button.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
    required this.title,
    this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
    this.subWidgetPrefixIcon,
    this.mainPrefixIcon,
    this.subTitle2,
    this.subTitleStyle2,
    this.bottomButtonText,
    this.bottomButtonIcon,
  });

  final String title;
  final String? subTitle;
  final String? subTitle2;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final TextStyle? subTitleStyle2;
  final IconData? subWidgetPrefixIcon;
  final IconData? mainPrefixIcon;
  final String? bottomButtonText;
  final IconData? bottomButtonIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: mainPrefixIcon != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: mainPrefixIcon != null,
          child: Icon(
            mainPrefixIcon,
            size: 30,
          ),
        ),
        Visibility(
          visible: mainPrefixIcon != null,
          child: const SizedBox(
            width: 10,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ScreenUtils.width * 0.8,
              ),
              child: Text(
                title,
                style: titleStyle ??
                    const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: subWidgetPrefixIcon != null,
                  child: Icon(
                    subWidgetPrefixIcon,
                    size: 20,
                  ),
                ),
                Visibility(
                  visible: subTitle != null,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: ScreenUtils.width * 0.8,
                    ),
                    child: Text(
                      subTitle ?? '',
                      style: subTitleStyle ??
                          const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: subTitle2 != null,
              child: Text(
                subTitle2 ?? '',
                style: subTitleStyle2 ??
                    const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mediumGrey,
                    ),
              ),
            ),
            Visibility(
              visible: bottomButtonText != null,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: SizedBox(
                  height: ScreenUtils.height * 0.05,
                  width: ScreenUtils.width * 0.4,
                  child: MainButton(
                      iconForButton: bottomButtonIcon ?? Icons.done,
                      buttonText: bottomButtonText ?? 'Following',
                      borderColor: AppColors.mediumGrey,
                      buttonTextStyle: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mediumGrey,
                      )),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
