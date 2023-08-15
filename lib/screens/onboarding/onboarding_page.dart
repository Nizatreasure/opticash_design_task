import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
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
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.red,
              child: Stack(
                alignment: const Alignment(0, -0.1),
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
                    bottom: -70,
                    left: 0,
                    right: size.width * 0.15,
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
          Expanded(
            child: Column(
              children: [
                Text(
                  'Send Money faster than Imagined',
                  style: themeData.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
