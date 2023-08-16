import 'package:design_task/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final List<TextInputFormatter> inputFormatters;
  final bool isPassword;
  final bool showText;
  final void Function()? onTapSuffix;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  const CustomInputField({
    required this.controller,
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.showText = true,
    this.onTapSuffix,
    this.onChanged,
    this.inputFormatters = const [],
    this.keyboardType = TextInputType.name,
    this.textCapitalization = TextCapitalization.words,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(listener);
    _focusNode.dispose();
    super.dispose();
  }

  listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Stack(
        children: [
          TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            onChanged: widget.onChanged ??
                (value) {
                  setState(() {});
                },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: deepGreen,
            obscureText: !widget.showText,
            keyboardType: widget.keyboardType,
            obscuringCharacter: '\u26AB',
            textCapitalization: widget.textCapitalization,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: themeData.textTheme.bodyMedium,
              label: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9FB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.labelText,
                  style: themeData.textTheme.bodyMedium!.copyWith(fontSize: 16),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE30101),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE30101),
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: deepGreen,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: !widget.isPassword
                  ? null
                  : GestureDetector(
                      onTap: widget.onTapSuffix,
                      child: Container(
                        color: Colors.transparent,
                        child: Icon(
                          widget.showText
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 17,
                          color: _focusNode.hasFocus
                              ? deepGreen
                              : themeData.textTheme.bodyMedium!.color,
                        ),
                      ),
                    ),
            ),
            validator: widget.validator ??
                (value) {
                  return value!.trim().isEmpty
                      ? '${widget.labelText[0].toUpperCase()}${widget.labelText.substring(1).toLowerCase()} is required'
                      : null;
                },
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ...widget.inputFormatters
            ],
            style: themeData.textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
