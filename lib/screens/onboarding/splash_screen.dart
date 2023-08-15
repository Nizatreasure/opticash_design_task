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
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _verticalController;
  late Animation<double> _verticalAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _verticalController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _verticalAnimation = Tween<double>(begin: 10, end: -10).animate(
      CurvedAnimation(
        parent: _verticalController,
        curve: Curves.easeInOut,
      ),
    );
    _controller.addListener(controllerListener);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(controllerListener);
    _verticalController.dispose();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  controllerListener() async {
    setState(() {});
    if (_controller.isCompleted) {
      _verticalController.repeat(reverse: true);
      Future.delayed(const Duration(seconds: 3)).then((value) {
        _verticalController.stop();
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
              child: AnimatedBuilder(
                  animation: _verticalAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _verticalAnimation.value),
                      child: Container(
                        width: double.infinity,
                        foregroundDecoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/splash/network-particle.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/splash/rectangle.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 10),
            AnimatedBuilder(
              animation: _verticalAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _verticalAnimation.value),
                  child: child,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                width: _animation.value * 0.25 * size.width,
                height: _animation.value * 0.14 * size.height,
                child: Image.asset(
                  'assets/images/opticash-icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
