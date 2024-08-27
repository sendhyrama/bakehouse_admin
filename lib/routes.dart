import 'package:bakehouse_admin/pages/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/navbar_state.dart';
import 'pages/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String loginAdmin = '/login-admin';
  static const String homeAdmin = '/home-admin';
  static const String navbarAdmin = '/navbar-admin';
  static const String editProfileAdmin = '/edit-profile-admin';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      loginAdmin: (context) => const LoginAdminPage(),
      homeAdmin: (context) => const HomePage(),
      navbarAdmin: (context) => const NavbarAdmin(),
      // editProfileAdmin: (context) => const EditProfilePage(userData: userData),
    };
  }
}
