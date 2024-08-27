import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/shared_prefs.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null) {
    _init();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _init() {
    state = _auth.currentUser;
    _auth.authStateChanges().listen((user) {
      state = user;
    });
  }

  Future<void> checkAuthStatus() async {
    state = _auth.currentUser;
    if (state != null) {
      String? storedRole = SharedPrefs.getString('userRole');
      if (storedRole == null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(state!.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          String userRole = userData['role'];
          await SharedPrefs.setString('userRole', userRole);
        }
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        String userRole = userData['role'];
        await SharedPrefs.setString('userRole', userRole);
        await SharedPrefs.setString('userId', userCredential.user!.uid);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await SharedPrefs.remove('userRole');
    await SharedPrefs.remove('userId');
    state = null;
  }

  String? get userRole => SharedPrefs.getString('userRole');
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
