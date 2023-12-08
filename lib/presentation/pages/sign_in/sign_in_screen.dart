import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/business_logic/blocs/authentication_bloc.dart';
import 'package:linkedin_clone/business_logic/blocs/sign_in/sign_in_bloc.dart';
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
import 'package:quickalert/quickalert.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isObscureText = true;

  // FORM RELATED
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _autoValidate = false;

  // final AuthenticationRepository _authenticationRepository =
  //     AuthenticationRepository();
  // late SignInBloc signInBloc;

  @override
  void initState() {
    // signInBloc = SignInBloc(
    //   authenticationRepository: _authenticationRepository,
    // );
    super.initState();
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    // signInBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      bloc: context.read<SignInBloc>(),
      listener: (context, state) {
        if (state is SignInFailure) {
          printLogs('SIGN IN FAILED!');
          printLogs(state.errorMessage);
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Failed',
            text: state.errorMessage,
          );
        }
        if (state is SignInFormLoading) {
          printLogs('SIGN IN SUBMITTING!');
        }
        if (state is SignInSuccess) {
          printLogs('SIGN IN SUCCESS');
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          printLogs(state.firebaseUser?.email ?? '');
          moveToScreen(context, ScreenRoutes.toMainScreen, arguments: {
            'authUser': state.firebaseUser,
          });
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        bloc: context.read<SignInBloc>(),
        builder: (context, state) {
          return MainLayout(
            verticalPadding: ScreenUtils.height * 0.05,
            loading: state is SignInFormLoading ? true : false,
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _mainTitle(),
                _signInForm(),
                _socialLogins(),
              ],
            ),
          );
        },
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
            'Sign in',
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

  Widget _signInForm() {
    return Form(
      key: _formkey,
      autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: SizedBox(
        height: ScreenUtils.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextField(
              hintText: 'Email or Phone',
              controller: _emailOrPhoneController,
              validator: (value) {
                if (!isValidEmail(value) && !isValidPhone(value ?? '')) {
                  return 'Please enter a valid email or phone number.';
                }
                return null;
              },
            ),
            CustomTextField(
              hintText: 'Password',
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
              suffixWidget: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Text(
                  isObscureText ? 'show' : 'hide',
                  style: const TextStyle(
                    color: AppColors.blue,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Todo : Forgot password flow
              },
              child: const Text(
                'Forgot Password ?',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MainButton(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  // Email & password - SIGN IN FLOW
                  BlocProvider.of<SignInBloc>(context).add(
                    LoginWithCredentialsPressed(
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
              buttonText: 'Sign in',
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
      height: ScreenUtils.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MainButton(
            onTap: () {
              // to-do : Google Sign In
              BlocProvider.of<SignInBloc>(context)
                  .add(SignInWithGooglePressed());
            },
            prefixImageName: googleIcon,
            buttonText: 'Sign in with google',
            buttonColor: AppColors.white,
            borderColor: AppColors.grey,
            buttonTextStyle: const TextStyle(
              fontSize: 15,
              color: AppColors.black,
            ),
          ),
          MainButton(
            onTap: () {
              // to-do : Apple Sign In
            },
            prefixImageName: appleIcon,
            buttonText: 'Sign in with apple',
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
                ScreenRoutes.toSignUpScreen,
              );
            },
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Create new account? ',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  TextSpan(
                    text: ' Register',
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
