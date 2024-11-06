import 'package:dicoding_voiceapp/core/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final String? initialValue;
  final FormFieldValidator<String> validator;
  final VoidCallback? visibilityPass;
  final bool? visibilityTogle;
  final TextEditingController controller;

  const CustomTextForm({
    super.key,
    this.obscureText = false,
    this.visibilityPass,
    this.visibilityTogle,
    this.initialValue,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.errorColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.errorColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          fillColor: AppColors.accent3,
          filled: true,
          hintText: hintText,
          border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
          hintStyle: const TextStyle(fontSize: 14),
          suffixIcon: obscureText
              ? InkWell(
                  onTap: () {
                    visibilityPass!();
                  },
                  child: Icon(
                    visibilityTogle == true ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primaryColor,
                    size: 18.0,
                  ),
                )
              : null,
        ),
        obscureText: visibilityTogle ?? false,
        validator: validator,
      ),
    );
  }
}
