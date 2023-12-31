import 'package:design_task/helpers/constants.dart';
import 'package:design_task/screens/authentication/sign_up/sign_up.dart';
import 'package:design_task/shared/custom_button.dart';
import 'package:flutter/material.dart';

import '../authentication/sign_in/sign_in.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: size.height < 750 ? 3 : 4,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: (size.height < 750 ? 0.025 : 0.04) * size.height),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0.04 * size.height,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Image.asset(
                          'assets/images/onboarding/pattern.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        bottom: -100,
                        left: 0,
                        right: size.width * 0.1,
                        child: Image.asset(
                          'assets/images/onboarding/line.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Image.asset('assets/images/onboarding/people.png')
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              right:
                                  (size.width < 400 ? 0.1 : 0.15) * size.width),
                          child: Text(
                            'Send Money faster than Imagined',
                            style: themeData.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.only(
                              right:
                                  (size.width < 400 ? 0.15 : 0.2) * size.width),
                          child: Text(
                            'Opticash provides you the fastest remittance to send and receive money!',
                            style: themeData.textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFFCFCFCF),
                            ),
                          ),
                        ),
                        SizedBox(height: 0.043 * size.height),
                        Row(
                          children: [
                            _progressIndicator(true),
                            _progressIndicator(false),
                            _progressIndicator(false),
                          ],
                        ),
                        SizedBox(height: 0.04 * size.height),
                        CustomButton(
                          text: 'Create New Account',
                          gradient: LinearGradient(
                            end: const Alignment(1.00, -0.04),
                            begin: const Alignment(-1, -0.04),
                            colors: [
                              livelyGreen,
                              pastelYellow,
                            ],
                          ),
                          textColor: black,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, SignUpScreen.routeName);
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, SignInScreen.routeName);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Sign In',
                                style: themeData.textTheme.bodyLarge!.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
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
    );
  }

  Widget _progressIndicator(bool isActive) {
    return Container(
      height: 2,
      width: (MediaQuery.of(context).size.width - 72) / 5,
      margin: const EdgeInsets.only(right: 8),
      color: isActive ? const Color(0xFFC1D138) : const Color(0xFFA0A0A0),
    );
  }
}
