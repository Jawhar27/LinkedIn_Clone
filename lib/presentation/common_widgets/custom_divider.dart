import 'package:flutter/material.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.isNormalDivider = false,
    this.dividerColor,
    this.dividerHeight = 0.0,
  });

  final bool isNormalDivider;
  final Color? dividerColor;
  final double dividerHeight;

  @override
  Widget build(BuildContext context) {
    return isNormalDivider
        ? Container(
            height: dividerHeight,
            width: ScreenUtils.width,
            color: dividerColor,
          )
        : SizedBox(
            height: ScreenUtils.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 1.0,
                    color: AppColors.grey,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'or',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 1.0,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          );
  }
}
