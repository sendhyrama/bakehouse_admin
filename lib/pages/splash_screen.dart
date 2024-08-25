import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/status_bar.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    StatusBar.setLightStatusBar();

    _controller = AnimationController(
      duration: AppConstants.splashScreenDuration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    // Perform auth check while animation is running
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).checkAuthStatus();
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    final authState = ref.read(authProvider);
    if (authState != null) {
      String? userRole = ref.read(authProvider.notifier).userRole;
      if (userRole == 'admin') {
        Navigator.pushReplacementNamed(context, '/navbar-admin');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login-admin');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor.c8,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: SvgPicture.asset(
            AppConstants.logoPath,
            width: 200,
          ),
        ),
      ),
    );
  }
}
