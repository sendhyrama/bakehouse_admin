import 'package:bakehouse_admin/services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

final totalUsersProvider = FutureProvider<int>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalUsers();
});

final totalUMKMProvider = FutureProvider<int>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalUMKM();
});

final totalCustomersProvider = FutureProvider<int>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalCustomers();
});

final totalProductsProvider = FutureProvider<int>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalProducts();
});

final totalCompletedOrdersProvider = FutureProvider<int>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalCompletedOrders();
});
