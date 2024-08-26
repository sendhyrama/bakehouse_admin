import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  Future<User?> getUserById(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      return User.fromMap(doc.data()!);
    } else {
      return null;
    }
  }

  Future<List<User>> getUsersByRole(String role) async {
    final snapshot =
        await _db.collection('users').where('role', isEqualTo: role).get();
    return snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
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
}
