import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/business_logic/blocs/authentication_bloc.dart';
import 'package:linkedin_clone/business_logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:linkedin_clone/presentation/common_widgets/main_button.dart';
import 'package:linkedin_clone/presentation/layouts/main_layout.dart';
import 'package:linkedin_clone/presentation/utils/navigation_util.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';
import 'package:linkedin_clone/presentation/utils/sample_data/onboard_slider_data.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';
import 'package:linkedin_clone/routes.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnboardData> onBoardingData = OnboardData.onBoardingDataList;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          printLogs('GOOGLE SIGN IN FAILED!');
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Failed',
            text: state.errorMessage,
          );
        }
        if (state is SignInFormLoading) {
          printLogs('GOOGLE SIGN IN SUBMITTING!');
        }
        if (state is SignInSuccess) {
          printLogs('GOOGLE SIGN IN SUCCESS');
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          printLogs(state.firebaseUser?.email ?? '');
          moveToScreen(
            context,
            ScreenRoutes.toMainScreen,
          );
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return MainLayout(
            loading: state is SignInFormLoading ? true : false,
            verticalPadding: ScreenUtils.height * 0.04,
            bodyWidget: PageView.builder(
              itemCount: onBoardingData.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: ScreenUtils.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _imageWithContent(index),
                      _navigationOptions(),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _imageWithContent(int index) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          appIconSvg,
          width: 50,
          height: 50,
        ),
        Image.asset(
          onBoardingData[index].image ?? sliderImage1,
          height: ScreenUtils.height * 0.4,
          width: ScreenUtils.width,
          fit: BoxFit.contain,
        ),
        Center(
          child: Text(
            "${onBoardingData[index].title}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: index == 0
                      ? AppColors.linkedInBlue
                      : AppColors.linkedInWhite,
                  border: Border.all(
                    width: 1,
                  ),
                  shape: BoxShape.circle),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: index == 1
                      ? AppColors.linkedInBlue
                      : AppColors.linkedInWhite,
                  border: Border.all(
                    width: 1,
                  ),
                  shape: BoxShape.circle),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: index == 2
                    ? AppColors.linkedInBlue
                    : AppColors.linkedInWhite,
                border: Border.all(
                  width: 1,
                  color: index == 2
                      ? AppColors.linkedInBlue
                      : AppColors.linkedInDarkGrey,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _navigationOptions() {
    return SizedBox(
      height: ScreenUtils.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainButton(
            buttonText: 'Join Now',
            onTap: () {
              moveToScreen(
                context,
                ScreenRoutes.toSignUpScreen,
              );
            },
            buttonColor: AppColors.blue,
            buttonTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          MainButton(
            onTap: () {
              // to-do : Google Sign In
              BlocProvider.of<SignInBloc>(context).add(
                SignInWithGooglePressed(),
              );
            },
            prefixImageName: googleIcon,
            buttonText: 'Sign in with google',
            buttonColor: AppColors.white,
            borderColor: AppColors.grey,
            buttonTextStyle: const TextStyle(
              fontSize: 15,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                moveToScreen(
                  context,
                  ScreenRoutes.toSignInScreen,
                );
              },
              child: const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.linkedInBlue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
