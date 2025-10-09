import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';

class CustomTextformfield extends StatelessWidget {
  const CustomTextformfield({
    super.key,
    this.inputFormatters,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.autofocus,
    this.autovalidateMode,
    this.style,
    this.labelText,
    this.hintText,
    this.validator,
    this.onChanged,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.errorText,
  });
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final TextStyle? style;
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      validator: validator,
      onChanged: onChanged,
      cursorColor: ColorString.eucalyptus,
      cursorErrorColor: ColorString.eucalyptus,
      obscureText: obscureText ?? false,
      style: TextStyle(
        color: ColorString.jewel,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black45
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black45,
          overflow: TextOverflow.ellipsis,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: ColorString.jewel,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0),
        )
      )
    );
  }
}