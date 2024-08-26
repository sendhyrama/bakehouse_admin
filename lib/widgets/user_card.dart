import 'package:bakehouse_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/text_styles.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: _getAvatarImage(user),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.role == 'customer') ...[
                  Text(user.fullname ?? '', style: TextStyles.h3),
                  const SizedBox(height: 4),
                  Text(user.email ?? '', style: TextStyles.b1),
                  const SizedBox(height: 4),
                  Text(user.phone ?? '', style: TextStyles.b1),
                ] else if (user.role == 'merchant') ...[
                  Text(user.businessName ?? '', style: TextStyles.h3),
                  const SizedBox(height: 4),
                  Text(user.businessEmail ?? '', style: TextStyles.b1),
                  const SizedBox(height: 4),
                  Text(user.phone ?? '', style: TextStyles.b1),
                ],
              ],
            ),
          ],
        ),
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
      return const AssetImage(AppConstants.userPlaceholderPath);
    }
  }
}
