import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/business_logic/blocs/authentication_bloc.dart';
import 'package:linkedin_clone/business_logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:linkedin_clone/business_logic/blocs/sign_up/sign_up_bloc.dart';
import 'package:linkedin_clone/data/repository/authentication_repository.dart';
import 'package:linkedin_clone/presentation/common_widgets/custom_divider.dart';
import 'package:linkedin_clone/presentation/common_widgets/custom_text_field.dart';
import 'package:linkedin_clone/presentation/common_widgets/main_button.dart';
import 'package:linkedin_clone/presentation/layouts/main_layout.dart';
import 'package:linkedin_clone/presentation/utils/navigation_util.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';
import 'package:linkedin_clone/presentation/utils/response_util.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';
import 'package:linkedin_clone/presentation/utils/validation_util.dart';
import 'package:linkedin_clone/routes.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscureText = true;

  // FORM RELATED
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _autoValidate = false;

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  late SignUpBloc signUpBloc;

  @override
  void initState() {
    signUpBloc = SignUpBloc(
      authenticationRepository: _authenticationRepository,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    signUpBloc.close();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => signUpBloc,
      child: BlocListener<SignUpBloc, SignUpState>(
        bloc: signUpBloc,
        listener: (context, state) {
          if (state is SignUpFormLoading) {
            printLogs('Form loadingg!!');
          }
          if (state is GoogleSignUpSuccess) {
            printLogs('Google Signup Success');
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            moveToScreen(context, ScreenRoutes.toMainScreen);
          }
          if (state is SignUpSuccess) {
            printLogs('Signup Success');
            QuickAlert.show(
              barrierDismissible: false,
              context: context,
              type: QuickAlertType.success,
              title: 'Success',
              text: 'User registration successfull!',
              confirmBtnText: 'To Sign in',
              onConfirmBtnTap: () {
                moveToScreen(
                  context,
                  ScreenRoutes.toSignInScreen,
                );
              },
            );
          }

          if (state is SignUpFailure) {
            printLogs(state.errorMessage);
            printLogs('Failed signup');
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Failed',
              text: state.errorMessage,
            );
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          bloc: signUpBloc,
          builder: (context, state) {
            return MainLayout(
              loading:
                  (context.watch<SignInBloc>().state is SignInFormLoading ||
                          state is SignUpFormLoading)
                      ? true
                      : false,
              bodyWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _mainTitle(),
                  _signUpForm(),
                  _socialLogins(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _mainTitle() {
    return SizedBox(
      height: ScreenUtils.height * 0.1,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Stay updated on your professional world!',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formkey,
      autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: SizedBox(
        height: ScreenUtils.height * 0.57,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextField(
              labelText: 'Email',
              hintText: 'Email',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              suffixIconWidget: const Icon(Icons.email),
              controller: _emailOrPhoneController,
              validator: (value) {
                if (!isValidEmail(value) && !isValidPhone(value ?? '')) {
                  return 'Please enter a valid email or phone number.';
                }
                return null;
              },
            ),
            CustomTextField(
              labelText: 'Password (6 characters minimum)',
              hintText: 'Password',
              suffixIconWidget: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Icon(
                  isObscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              controller: _passwordController,
              isObscureText: isObscureText,
              validator: (password) {
                PasswordValidationResult result =
                    validatePassword(password ?? '');
                if (!result.isValid) {
                  return result.error;
                }
                return null;
              },
            ),
            const Center(
                child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'By clicking Accept and Register, you agree to the ',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms of use,',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                      fontSize: 13.0,
                    ),
                  ),
                  TextSpan(
                    text: '\nthe',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  TextSpan(
                    text: ' Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                      fontSize: 13.0,
                    ),
                  ),
                  TextSpan(
                    text: ' and',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  TextSpan(
                    text: ' cookies Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                      fontSize: 13.0,
                    ),
                  ),
                  TextSpan(
                    text: ' LinkedIn',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )),
            MainButton(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  // Email & password - SIGN UP FLOW
                  signUpBloc.add(
                    SignUpWithCredentials(
                      email: _emailOrPhoneController.text,
                      password: _passwordController.text,
                    ),
                  );
                } else {
                  setState(() {
                    _autoValidate = true;
                  });
                }
              },
              buttonText: 'Accept and Register',
              buttonColor: AppColors.blue,
              buttonTextStyle: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const CustomDivider(),
          ],
        ),
      ),
    );
  }

  Widget _socialLogins() {
    return SizedBox(
      height: ScreenUtils.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MainButton(
            onTap: () {
              // to-do : Google Sign In
              signUpBloc.add(
                SignUpWithGooglePressed(),
              );
            },
            prefixImageName: googleIcon,
            buttonText: 'Sign up with google',
            buttonColor: AppColors.white,
            borderColor: AppColors.grey,
            buttonTextStyle: const TextStyle(
              fontSize: 15,
              color: AppColors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              pushScreen(
                context,
                ScreenRoutes.toSignInScreen,
              );
            },
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Already registered? ',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  TextSpan(
                    text: ' Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
