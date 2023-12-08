import 'package:flutter/material.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';

class TitlewithPercentIndicator extends StatelessWidget {
  const TitlewithPercentIndicator({
    super.key,
    required this.title,
    required this.percentage,
    this.subTitle,
    this.subtitleWidget,
  });
  final double percentage;
  final String title;
  final String? subTitle;
  final Widget? subtitleWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: ScreenUtils.width * 0.85,
                child: Container(
                    height: ScreenUtils.height * 0.02,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.linkedInDarkGrey,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtils.width * 0.55,
                          decoration: BoxDecoration(
                            color: AppColors.mediumGrey,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ],
                    )),
              ),
              const Text(
                '5/7',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mediumGrey,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: subtitleWidget != null,
          child: subtitleWidget ?? const SizedBox(),
        ),
        Visibility(
          visible: subTitle != null,
          child: Text(
            subTitle ?? '',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
        )
      ],
    );
  }
}
