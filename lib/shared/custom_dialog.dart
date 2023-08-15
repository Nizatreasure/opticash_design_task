import 'dart:ui';

import 'package:design_task/shared/custom_button.dart';
import 'package:flutter/material.dart';

import '../main.dart';

Future<bool> showCustomDialog(
  String text, {
  required String buttonText,
  void Function()? onTap,
}) async {
  ThemeData themeData = Theme.of(MyApp.navigatorKey.currentContext!);
  Size size = MediaQuery.of(MyApp.navigatorKey.currentContext!).size;
  bool? returnValue = await showDialog(
    context: MyApp.navigatorKey.currentContext!,
    useRootNavigator: true,
    barrierDismissible: false,
    barrierColor: const Color(0x562D3B51),
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Dialog(
              backgroundColor: themeData.scaffoldBackgroundColor,
              elevation: 30,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              insetPadding: const EdgeInsets.all(40),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 0.28 * size.width,
                      height: 0.09 * size.height,
                      child: Image.asset(
                        'assets/images/opticash-icon.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF0F0F0F),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: buttonText,
                      textColor: Colors.white,
                      color: const Color(0xFF627122),
                      radius: 12,
                      height: 48,
                      onTap: onTap ??
                          () {
                            Navigator.pop(context);
                          },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  return returnValue == true;
}
