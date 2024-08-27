import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';
import '../../routes.dart';
import 'edit_profile_page.dart';
// import 'edit_profile_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc.data() as Map<String, dynamic>;
    }
    return {};
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Profil',
              style: TextStyles.h2.copyWith(color: Colors.white),
            ),
          ),
          backgroundColor: PrimaryColor.c8,
          automaticallyImplyLeading: false,
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Error loading profile"));
          }

          var userData = snapshot.data!;
          var profileImageUrl = userData['profileImageUrl'];
          var userFullname = userData['fullname'];

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      userFullname,
                      style: TextStyles.h3.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 12),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                          profileImageUrl != null && profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : null,
                      child: profileImageUrl == null || profileImageUrl.isEmpty
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.grey)
                          : null,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushReplacementNamed(context, Routes.homeAdmin, arguments: 4);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(userData: userData),
                          ),
                        );
                      },
                      child: Text(
                        'Edit Profil',
                        style: TextStyles.b1.copyWith(color: PrimaryColor.c8),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              _buildListTile(
                context,
                icon: Icons.help_outline,
                title: 'Pusat Bantuan',
                onTap: () {
                  // Navigate to the respective page
                },
              ),
              _buildListTile(
                context,
                icon: Icons.description_outlined,
                title: 'Syarat & Ketentuan',
                onTap: () {
                  // Navigate to the respective page
                },
              ),
              _buildListTile(
                context,
                icon: Icons.lock_outline,
                title: 'Kebijakan Privasi',
                onTap: () {
                  // Navigate to the respective page
                },
              ),
              _buildListTile(
                context,
                icon: Icons.info_outline,
                title: 'Tentang',
                onTap: () {
                  // Navigate to the respective page
                },
              ),
              _buildListTile(
                context,
                icon: Icons.settings_outlined,
                title: 'Pengaturan Akun',
                onTap: () {
                  // Navigate to the respective page
                },
              ),
              _buildListTile(
                context,
                icon: Icons.exit_to_app,
                title: 'Keluar',
                onTap: () => _signOut(context, ref),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: PrimaryColor.c8,
      ),
      title: Text(
        title,
        style: TextStyles.b1,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
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
      print("Error logout: $e");
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
