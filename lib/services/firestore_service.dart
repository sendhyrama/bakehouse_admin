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
      throw Exception('Error deleting user: $e');
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
                User.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<int> getTotalUsers() async {
    QuerySnapshot snapshot = await _db.collection('users').get();
    return snapshot.size;
  }

  Future<int> getTotalUMKM() async {
    QuerySnapshot snapshot = await _db
        .collection('users')
        .where('role', isEqualTo: 'merchant')
        .get();
    return snapshot.size;
  }

  Future<int> getTotalCustomers() async {
    QuerySnapshot snapshot = await _db
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .get();
    return snapshot.size;
  }

  Future<int> getTotalProducts() async {
    QuerySnapshot snapshot = await _db.collection('products').get();
    return snapshot.size;
  }

  Future<int> getTotalCompletedOrders() async {
    QuerySnapshot snapshot = await _db
        .collection('orders')
        .where('orderStatus', isEqualTo: 'Selesai')
        .get();
    return snapshot.size;
  }

  Future<void> deleteProduct(String productId) async {
    await _db.collection('products').doc(productId).delete();
  }
}
