import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
      ),
      body: const Center(
        child: Text('Ini halaman daftar produk UMKM min!'),
      ),
    );
  }
}
