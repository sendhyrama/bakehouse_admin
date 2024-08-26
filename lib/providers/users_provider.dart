import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import 'firestore_service_provider.dart';

final usersByRoleProvider = StreamProvider.family<List<User>, String>((ref, role) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getUsersByRole(role);
});

final deleteUserProvider = FutureProvider.family<void, String>((ref, userId) async {
  return FirestoreService().deleteUser(userId);
});