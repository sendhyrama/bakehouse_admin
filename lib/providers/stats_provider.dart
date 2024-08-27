import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firestore_service_provider.dart';

final totalUMKMProvider = StreamProvider<int>((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalUMKM();
});

final totalCustomersProvider = StreamProvider<int>((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalCustomers();
});

final totalProductsProvider = StreamProvider<int>((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalProducts();
});

final totalCompletedOrdersProvider = StreamProvider<int>((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getTotalCompletedOrders();
});
