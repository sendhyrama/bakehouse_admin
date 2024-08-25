import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

class ImageUploadField extends StatefulWidget {
  final File? imageFile;
  final String? imageUrl;
  final VoidCallback onTap;
  final String? labelText;
  final String? hintText;
  final String? optionalLabelText;
  final String? Function(File?)? validator; // Add validator parameter

  const ImageUploadField({
    super.key,
    this.imageFile,
    this.imageUrl,
    required this.onTap,
    this.optionalLabelText,
    this.labelText,
    this.hintText,
    this.validator, // Initialize validator
  });

  @override
  _ImageUploadFieldState createState() => _ImageUploadFieldState();
}

class _ImageUploadFieldState extends State<ImageUploadField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.labelText != null) ...[
          Text(widget.labelText!, style: TextStyles.b1),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: () {
            widget.onTap();
            // Validate after image is picked
            if (widget.validator != null) {
              setState(() {
                _errorText = widget.validator!(widget.imageFile);
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (widget.imageFile != null)
                  Image.file(widget.imageFile!, width: 100, height: 100)
                else if (widget.imageUrl != null)
                  Image.network(widget.imageUrl!, width: 100, height: 100)
                else
                  SvgPicture.asset('assets/icons/email.svg', width: 100),
                const SizedBox(height: 8),
                if (widget.optionalLabelText != null) ...[
                  Text(widget.optionalLabelText!,
                      style: TextStyles.b1.copyWith(color: NeutralColor.c8)),
                ],
                if (_errorText != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (widget.hintText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.hintText!,
            style: TextStyles.b2,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
