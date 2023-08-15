import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double radius;
  final double? width;
  final double height;
  final Gradient? gradient;
  final Color? color;
  final String text;
  final Color? textColor;
  final void Function()? onTap;
  const CustomButton({
    this.radius = 5,
    this.width,
    this.height = 60,
    super.key,
    this.gradient,
    this.color,
    required this.text,
    this.onTap,
    this.textColor,
  }) : assert(gradient != null || color != null,
            'Either color or gradient must be provided.');

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: width ?? double.infinity,
        alignment: Alignment.center,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: gradient,
          color: color,
        ),
        child: Text(
          text,
          style: themeData.textTheme.bodyLarge!
              .copyWith(color: textColor, fontSize: 16),
        ),
      ),
    );
  }
}
