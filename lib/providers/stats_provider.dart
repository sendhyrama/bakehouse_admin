import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firestore_service_provider.dart';

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
