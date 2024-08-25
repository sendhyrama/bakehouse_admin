import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final double height;

  BottomNavBar(
      {required this.selectedIndex,
      required this.onItemTapped,
      this.height = 70.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgIcon("assets/icons/beranda.svg", 0),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon("assets/icons/pengguna.svg", 1),
            label: 'Pengguna',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon("assets/icons/produk.svg", 2),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon("assets/icons/profil.svg", 3),
            label: 'Profil',
          ),
        ],
        selectedItemColor: PrimaryColor.c8,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyles.b2.copyWith(color: PrimaryColor.c8),
        unselectedLabelStyle: TextStyles.b2.copyWith(color: Colors.grey),
      ),
    );
  }

  Widget _buildSvgIcon(String assetPath, int index) {
    return SvgPicture.asset(
      assetPath,
      color: selectedIndex == index ? null : Colors.grey,
    );
  }
}
