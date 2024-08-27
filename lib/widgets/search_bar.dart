import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class SearchBarr extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  SearchBarr({required this.controller, required this.onSearch}) {
    // Add listener to the controller to handle live search
    controller.addListener(() {
      onSearch(controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            IconButton(
              icon: SvgPicture.asset('assets/icons/search.svg'),
              onPressed: () => onSearch(controller.text),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Cari disini',
                  border: InputBorder.none,
                  hintStyle: TextStyles.b1,
                ),
                onChanged: (text) {
                  // Call onSearch directly when text changes
                  onSearch(text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
