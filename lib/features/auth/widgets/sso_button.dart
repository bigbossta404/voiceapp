import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_color.dart';

class SsoButton extends StatelessWidget {
  final String svgAsset;
  final Color? svgColor;
  const SsoButton({super.key, required this.svgAsset, this.svgColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 100,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surfaceColor,
            side: const BorderSide(color: AppColors.accent1, width: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: SvgPicture.asset(
            svgAsset,
            // ignore: deprecated_member_use
            color: svgColor,
            width: 30,
          )),
    );
  }
}
