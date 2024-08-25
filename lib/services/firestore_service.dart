import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
