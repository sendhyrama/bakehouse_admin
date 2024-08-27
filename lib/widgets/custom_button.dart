import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final String? svgIconPath;
  final bool isEnabled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 48.0,
    this.svgIconPath,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimaryColor.c8,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgIconPath != null)
              SvgPicture.asset(
                svgIconPath!,
                width: 24,
                height: 24,
              ),
            if (svgIconPath != null) const SizedBox(width: 8),
            Text(text, style: TextStyles.b1),
          ],
        ),
      ),
    );
  }
}
