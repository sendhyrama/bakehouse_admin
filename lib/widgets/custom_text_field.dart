import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final String? svgIconPath;
  final bool isPassword;
  final TextInputType keyboardType;
  final int maxLines;
  final Function(String)? onChanged;
  final bool readOnly;
  final String? Function(String?)? validator; // Add validator parameter

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.svgIconPath,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.onChanged,
    this.readOnly = false,
    this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFilled = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkIfFilled);
  }

  void _checkIfFilled() {
    setState(() {
      _isFilled = widget.controller.text.isNotEmpty;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(widget.controller.text);
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(widget.labelText!, style: TextStyles.b1),
          const SizedBox(height: 4),
        ],
        TextFormField(
          // Change TextField to TextFormField
          style: TextStyles.b1
              .copyWith(color: _isFilled ? Colors.black : Colors.black),
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          validator: widget.validator, // Use the validator
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            hintText: widget.hintText,
            filled: true,
            fillColor: _isFilled ? PrimaryColor.c1 : Colors.white,
            prefixIcon: widget.svgIconPath != null
                ? SvgPicture.asset(
                    widget.svgIconPath!,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                    color: _isFilled ? Colors.black : Colors.black,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: _isFilled ? Colors.black : Colors.black,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _isFilled ? PrimaryColor.c8 : Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _isFilled ? PrimaryColor.c8 : Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: PrimaryColor.c8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkIfFilled);
    super.dispose();
  }
}
