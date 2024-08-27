import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => Product.fromMap(doc.id, doc.data()))
        .toList());
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
    } catch (e) {
      throw Exception('Error menghapus pengguna: $e');
    }
  }

  Future<User?> getUserById(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      return User.fromMap(doc.id, doc.data()!);
    } else {
      return null;
    }
  }

  Stream<List<User>> getUsersByRole(String role) {
    return _db
        .collection('users')
        .where('role', isEqualTo: role)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                User.fromMap(doc.id, doc.data()))
            .toList());
  }

  Stream<int> getTotalUMKM() {
    return _db
        .collection('users')
        .where('role', isEqualTo: 'merchant')
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<int> getTotalCustomers() {
    return _db
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<int> getTotalProducts() {
    return _db
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<int> getTotalCompletedOrders() {
    return _db
        .collection('orders')
        .where('orderStatus', isEqualTo: 'Selesai')
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Future<void> deleteProduct(String productId) async {
    await _db.collection('products').doc(productId).delete();
  }
}
