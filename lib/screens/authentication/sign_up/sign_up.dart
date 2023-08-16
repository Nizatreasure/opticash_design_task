import 'package:design_task/http_requests/authentication_request.dart';
import 'package:design_task/screens/authentication/sign_in/sign_in.dart';
import 'package:design_task/shared/custom_back_button.dart';
import 'package:design_task/shared/custom_button.dart';
import 'package:design_task/shared/custom_input_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/custom_dialog.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  double strength = -1.1;
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    activeIndex = strength <= 0
        ? 0
        : strength <= 0.25
            ? 1
            : strength <= 0.5
                ? 2
                : strength <= 0.75
                    ? 3
                    : 4;
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/images/authentication/money-pattern.png'),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(onTap: handleTap),
              const SizedBox(height: 25),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Account',
                            style: themeData.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(right: 0.13 * size.width),
                            child: Text(
                              'Register a new account using your email address and fill in your information',
                              style: themeData.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(height: 15),
                          CustomInputField(
                            controller: _firstNameController,
                            labelText: 'First Name',
                          ),
                          CustomInputField(
                            controller: _lastNameController,
                            labelText: 'Last Name',
                          ),
                          CustomInputField(
                            controller: _emailController,
                            labelText: 'Email',
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            validator: (p0) {
                              return p0!.trim().isEmpty
                                  ? 'Email is required'
                                  : !EmailValidator.validate(p0)
                                      ? 'Email is not valid'
                                      : null;
                            },
                          ),
                          CustomInputField(
                            controller: _passwordController,
                            labelText: 'Password',
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            showText: _showPassword,
                            onChanged: (p0) {
                              strength = estimatePasswordStrength(p0);
                              setState(() {});
                            },
                            onTapSuffix: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            validator: (p0) {
                              return p0!.trim().isEmpty
                                  ? 'Password is required'
                                  : null;
                            },
                          ),
                          if (activeIndex > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 5),
                              child: Row(
                                children: [
                                  ...List.generate(
                                    4,
                                    (index) => _indicator(index < activeIndex),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    strengthText(activeIndex),
                                    style: themeData.textTheme.bodyMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: activeIndex < 2
                                          ? const Color(0xFFE30101)
                                          : const Color(0xFF759C00),
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          const SizedBox(height: 35),
                          Align(
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: 'Already have an account? ',
                                style: themeData.textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: 'Sign In ',
                                    style:
                                        themeData.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = handleTap,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 15),
                          CustomButton(
                            text: 'CREATE NEW ACCOUNT',
                            onTap: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (activeIndex < 2) {
                                  showCustomDialog(
                                    'Password is too weak. Use a strong password to continue.',
                                    buttonText: 'Close',
                                  );
                                  return;
                                }
                                bool response =
                                    await AuthenticationRequest.register(
                                  email: _emailController.text.trim(),
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );

                                if (response) {
                                  await showCustomDialog(
                                    'Account Created Successfully',
                                    buttonText: 'Sign In',
                                  );
                                  handleTap();
                                }
                              }
                            },
                            textColor: Colors.white,
                            color: const Color(0xFF0A0A0A),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                horizontal: 0.1 * size.width, vertical: 12),
                            child: Text.rich(
                              TextSpan(
                                text: 'By signing up you agree to our ',
                                style: themeData.textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: 'Terms of Use ',
                                    style:
                                        themeData.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        privacyAndTerms(
                                            'https://opticash.io/terms-condition.html');
                                      },
                                  ),
                                  const TextSpan(text: 'and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style:
                                        themeData.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        privacyAndTerms(
                                            'https://opticash.io/privacy-policy.html');
                                      },
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 4,
      width: 18,
      margin: const EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
        color: isActive
            ? activeIndex < 2
                ? const Color(0xFFE30101)
                : const Color(0xFF759C00)
            : const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  String strengthText(int length) {
    return length == 0
        ? 'Very Weak'
        : length == 1
            ? 'Weak'
            : length == 2
                ? 'Moderate'
                : length == 3
                    ? 'Strong'
                    : 'Very Strong';
  }

  void handleTap() {
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  privacyAndTerms(String url) async {
    Uri uri = Uri.parse(url);
    bool canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      showCustomDialog('Failed to launch url', buttonText: 'Close');
    }
  }
}
