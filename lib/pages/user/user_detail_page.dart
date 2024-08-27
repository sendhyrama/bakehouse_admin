import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';
import '../../providers/users_provider.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/custom_text_field.dart';

class UserDetailPage extends ConsumerWidget {
  final User user;

  UserDetailPage({required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Detail Pengguna',
          style: TextStyles.h3,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              final confirmed = await _showConfirmationDialog(context);
              if (confirmed) {
                try {
                  await ref.read(deleteUserProvider(user.id).future);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${user.fullname ?? user.businessName} berhasil dihapus'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  _showErrorDialog(context, e.toString());
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _getAvatarImage(user),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.role == 'customer'
                  ? user.fullname ?? 'Unknown'
                  : user.businessName ?? 'Unknown',
              style: TextStyles.h3,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: TextEditingController(text: user.role),
              hintText: 'Kosong',
              labelText: 'Role',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: TextEditingController(text: user.phone),
              hintText: 'Kosong',
              labelText: 'No. Telepon',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            if (user.role == 'customer')
              CustomTextField(
                controller: TextEditingController(text: user.email),
                hintText: 'Kosong',
                labelText: 'Email',
                readOnly: true,
              )
            else
              CustomTextField(
                controller: TextEditingController(text: user.businessEmail),
                hintText: 'Kosong',
                labelText: 'Email',
                readOnly: true,
              ),
            const SizedBox(height: 16),
            if (user.role == 'customer')
              CustomTextField(
                controller: TextEditingController(text: user.bornDate),
                hintText: 'Kosong',
                labelText: 'Tanggal Lahir',
                readOnly: true,
              )
            else
              CustomTextField(
                controller:
                    TextEditingController(text: user.ownerName ?? 'Unknown'),
                hintText: 'Kosong',
                labelText: 'Nama Pemilik',
                readOnly: true,
              ),
            const SizedBox(height: 16),
            if (user.role == 'customer')
              CustomTextField(
                controller: TextEditingController(text: user.address),
                hintText: 'Kosong',
                labelText: 'Alamat',
                readOnly: true,
              )
            else
              CustomTextField(
                controller: TextEditingController(text: user.businessAddress),
                hintText: 'Kosong',
                labelText: 'Alamat Toko',
                readOnly: true,
              ),
            const SizedBox(height: 16),
            if (user.role == 'merchant')
              CustomTextField(
                controller:
                    TextEditingController(text: user.businessDescription),
                hintText: 'Kosong',
                labelText: 'Deskripsi Toko',
                readOnly: true,
                maxLines: 4,
              ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hapus Pengguna', style: TextStyles.h3),
            content: const Text(
              'Apakah Anda yakin ingin menghapus pengguna ini?',
              style: TextStyles.b1,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Batal',
                    style: TextStyles.b1.copyWith(color: NeutralColor.c7)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Hapus',
                    style: TextStyles.b1.copyWith(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Helper method to get the appropriate avatar image
  ImageProvider _getAvatarImage(User user) {
    if (user.role == 'merchant' &&
        user.businessLogo != null &&
        user.businessLogo!.isNotEmpty) {
      return NetworkImage(user.businessLogo!);
    } else if (user.profileImageUrl != null &&
        user.profileImageUrl!.isNotEmpty) {
      return NetworkImage(user.profileImageUrl!);
    } else {
      return const AssetImage('assets/icons/user.png');
    }
  }
}
