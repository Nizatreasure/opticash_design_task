import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addListener(controllerListener);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(controllerListener);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.dispose();
    super.dispose();
  }

  controllerListener() async {
    setState(() {});
    if (_controller.isCompleted) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pushReplacementNamed(context, OnboardingPage.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF090909),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                foregroundDecoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/splash/network-particle.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Image.asset(
                  'assets/images/splash/rectangle.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              width: _animation.value * 0.25 * size.width,
              height: _animation.value * 0.14 * size.height,
              child: Image.asset(
                'assets/images/opticash-icon.png',
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
