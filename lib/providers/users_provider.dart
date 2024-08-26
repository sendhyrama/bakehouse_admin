import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import 'firestore_service_provider.dart';

final usersByRoleProvider = FutureProvider.family<List<User>, String>((ref, role) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getUsersByRole(role);
});
