import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengguna'),
      ),
      body: const Center(
        child: Text('Ini halaman daftar pengguna min!'),
      ),
    );
  }
}
