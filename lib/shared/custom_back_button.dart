import 'package:design_task/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final void Function()? onTap;
  final double leftPadding;
  const CustomBackButton({this.onTap, this.leftPadding = 20, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: const Color(0xFF0F0B0B).withOpacity(0.6),
            width: 2,
          ),
        ),
        margin: EdgeInsets.only(left: leftPadding, top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 8),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: black,
          size: 18,
        ),
      ),
    );
  }
}
