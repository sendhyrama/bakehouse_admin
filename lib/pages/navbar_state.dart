import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/bottom_navbar.dart';
import 'home_page.dart';
import 'product_page.dart';
import 'profile/profile_page.dart';
import 'user_page.dart';

class NavbarAdmin extends StatefulWidget {
  final int initialIndex;

  const NavbarAdmin({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _NavbarAdminState createState() => _NavbarAdminState();
}

class _NavbarAdminState extends State<NavbarAdmin> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    const HomePage(),
    const UserPage(),
    const ProductPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
