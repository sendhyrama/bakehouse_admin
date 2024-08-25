import 'package:bakehouse_admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
                text: "Logout", onPressed: () => _signOut(context, ref))),
      ),
    );
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authProvider.notifier).signOut();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login-admin', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Signed Out!"),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sign Out failed: $e"),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}
