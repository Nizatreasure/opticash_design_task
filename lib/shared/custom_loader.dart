import 'dart:ui';

import 'package:design_task/helpers/constants.dart';
import 'package:design_task/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader {
  static BuildContext? _context;
  CustomLoader();

  static showLoader() {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.5),
      context: MyApp.navigatorKey.currentContext!,
      builder: (pageContext) {
        _context = pageContext;
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: const Alignment(0, -0.05),
                children: [
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  SpinKitWaveSpinner(
                    color: deepGreen,
                    waveColor: const Color(0xFF46521F),
                    trackColor: const Color(0xff94C419),
                    size: 110,

                    // child: Image.asset('assets/images/opticash-icon.png'),
                  ),
                  Image.asset(
                    'assets/images/opticash-icon.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> dismissLoader() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (_context != null && _context!.mounted) {
      Navigator.pop(_context!);
    }
  }
}
