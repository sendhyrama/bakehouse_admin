import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firestore_service_provider.dart';

final deleteProductProvider = FutureProvider.family<void, String>((ref, productId) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  await firestoreService.deleteProduct(productId);
});
