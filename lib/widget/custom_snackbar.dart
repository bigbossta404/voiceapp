import 'package:dicoding_voiceapp/core/app_color.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  final BuildContext context;
  final String type;
  final String message;

  CustomSnackbar(this.context, this.type, this.message)
      : super(
          duration: const Duration(seconds: 5),
          backgroundColor: type == 'error' ? AppColors.errorColor : AppColors.successColor,
          content: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${message}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ), // Text color
                ),
              ),
            ),
          ),
        );
}
