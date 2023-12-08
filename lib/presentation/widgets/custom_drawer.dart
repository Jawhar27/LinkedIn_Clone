import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/business_logic/blocs/authentication_bloc.dart';
import 'package:linkedin_clone/presentation/common_widgets/custom_divider.dart';
import 'package:linkedin_clone/presentation/utils/navigation_util.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';
import 'package:linkedin_clone/routes.dart';

Drawer buildDrawer({
  required BuildContext context,
}) {
  return Drawer(
    width: MediaQuery.of(context).size.width * 0.8,
    child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtils.width * 0.05,
          vertical: ScreenUtils.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // To-do : Navigate Profile Screen
                popScreen(context);
                pushScreen(
                  context,
                  ScreenRoutes.toProfileScreen,
                );
              },
              child: _personDetail(
                context,
                onClosePressed: () => popScreen(context),
              ),
            ),
            const CustomDivider(
              dividerHeight: 1.0,
              dividerColor: AppColors.linkedInLightGrey,
              isNormalDivider: true,
            ),
            SizedBox(
              height: ScreenUtils.height * 0.08,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '15 ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'profile viewers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mediumGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const CustomDivider(
              dividerHeight: 1.0,
              dividerColor: AppColors.linkedInLightGrey,
              isNormalDivider: true,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Groups',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Events',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: ScreenUtils.height * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CustomDivider(
                      dividerHeight: 1.0,
                      dividerColor: AppColors.linkedInLightGrey,
                      isNormalDivider: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LoggedOut());
                            moveToScreen(
                              context,
                              ScreenRoutes.toSignInScreen,
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
  );
}

SizedBox _personDetail(BuildContext context,
    {required void Function()? onClosePressed}) {
  return SizedBox(
    height: ScreenUtils.height * 0.2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              person,
              width: 60,
              height: 60,
            ),
            IconButton(
              onPressed: onClosePressed,
              icon: const Icon(
                Icons.close,
                color: AppColors.linkedInDarkGrey,
                size: 22,
              ),
            ),
          ],
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jawhar Sivagnanam',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            Text(
              'View profile',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.mediumGrey,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
