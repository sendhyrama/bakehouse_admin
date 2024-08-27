import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../providers/auth_provider.dart';
import '../utils/colors.dart';
import '../utils/status_bar.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginAdminPage extends ConsumerStatefulWidget {
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginAdminPage> createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends ConsumerState<LoginAdminPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _login() async {
    try {
      await ref.read(authProvider.notifier).signIn(
            _emailController.text,
            _passwordController.text,
          );

      String? userRole = ref.read(authProvider.notifier).userRole;

      if (userRole == 'admin') {
        _showSnackbar("Login Successful!");
        Navigator.pushNamed(context, '/navbar-admin');
      } else {
        _showSnackbar("You do not have permission to access this page.");
        await ref.read(authProvider.notifier).signOut();
      }
    } catch (e) {
      _showSnackbar("Login gagal: email atau password salah.");
    }
  }

  @override
  Widget build(BuildContext context) {
    StatusBar.setDarkStatusBar();
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  SvgPicture.asset('assets/images/logo-dark.svg', width: 180),
                  const SizedBox(height: 16),
                  Text(
                    'Masuk Admin',
                    style: TextStyles.h3.copyWith(color: PrimaryColor.c8),
                  ),
                  const SizedBox(height: 60),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    svgIconPath: 'assets/icons/email.svg',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    svgIconPath: 'assets/icons/password.svg',
                    isPassword: true,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Masuk',
                    onPressed: _login,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
