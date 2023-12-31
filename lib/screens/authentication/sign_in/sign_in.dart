import 'package:design_task/http_requests/authentication_request.dart';
import 'package:design_task/screens/authentication/sign_up/sign_up.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../shared/custom_back_button.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_input_field.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
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
                    padding: EdgeInsets.fromLTRB(
                        20, 0, 20, MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign In',
                            style: themeData.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(right: 0.13 * size.width),
                            child: Text(
                              'Sign In to your account using your email address and password',
                              style: themeData.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(height: 15),
                          CustomInputField(
                            controller: _emailController,
                            textCapitalization: TextCapitalization.none,
                            labelText: 'Email',
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
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.visiblePassword,
                            labelText: 'Password',
                            isPassword: true,
                            showText: _showPassword,
                            onChanged: (p0) {
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
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                              color: Colors.transparent,
                              child: Text(
                                'Forgot password',
                                style: themeData.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: 'Don‘t have an account? ',
                                style: themeData.textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: 'Create Account ',
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
                          const SizedBox(height: 30),
                          CustomButton(
                            text: 'SIGN IN',
                            onTap: () async {
                              setState(() {
                                _showPassword = false;
                              });
                              if (_formKey.currentState?.validate() ?? false) {
                                AuthenticationRequest.login(
                                  email: _emailController.text
                                      .trim()
                                      .toLowerCase(),
                                  password: _passwordController.text.trim(),
                                );
                              }
                            },
                            textColor: Colors.white,
                            color: const Color(0xFF0A0A0A),
                          ),
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

  void handleTap() {
    Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
  }
}
