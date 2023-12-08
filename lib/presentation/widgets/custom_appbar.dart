import 'package:flutter/material.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/presentation/common_widgets/custom_text_field.dart';
import 'package:linkedin_clone/presentation/utils/navigation_util.dart';

PreferredSizeWidget appBarWidget(
  BuildContext context, {
  VoidCallback? onProfileImageTap,
  String? hintText,
  bool isBackArrowNeeded = false,
  bool isProfileScreen = false,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 0,
    leading: GestureDetector(
      onTap: onProfileImageTap,
      child: Padding(
        padding: const EdgeInsets.all(
          4.0,
        ),
        child: isBackArrowNeeded
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  popScreen(context);
                },
              )
            : Image.asset(
                person,
              ),
      ),
    ),
    title: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.linkedInLightGrey.withOpacity(.5),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: CustomTextField(
        hintText: hintText ?? 'Search',
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        textFormFieldBorderRadius: 12.0,
        prefixIconWidget: const Icon(
          Icons.search,
        ),
        isBorderNeeded: false,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          // To-do : Navigate to Chat Screen
        },
        child: Icon(
          isProfileScreen ? Icons.settings : Icons.chat,
          size: 30,
          color: AppColors.mediumGrey,
        ),
      ),
      const SizedBox(
        width: 10,
      )
    ],
  );
}
