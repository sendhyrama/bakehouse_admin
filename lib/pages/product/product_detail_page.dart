import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/product_model.dart';
import '../../providers/product_provider.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';

class ProductDetailPage extends ConsumerWidget {
  final Product product;
  final String productId;

  const ProductDetailPage({
    required this.product,
    required this.productId,
    super.key,
  });

  Future<void> _onDeleteProduct(BuildContext context, WidgetRef ref) async {
    final confirmed = await _showConfirmationDialog(context);
    if (confirmed) {
      await ref.read(deleteProductProvider(productId).future);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil terhapus!')),
      );
      Navigator.pop(context);
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hapus Produk', style: TextStyles.h3),
            content: const Text(
              'Apakah kamu yakin ingin menghapus produk ini?',
              style: TextStyles.b1,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Batal',
                    style: TextStyles.b1.copyWith(color: NeutralColor.c7)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Hapus',
                    style: TextStyles.b1.copyWith(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyles.h3,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _onDeleteProduct(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(product.name, style: TextStyles.h2),
            const SizedBox(height: 8.0),
            Text('Kode Produk: ${productId.substring(0, 4)}',
                style: TextStyles.h4),
            const SizedBox(height: 16.0),
            const Text('Deskripsi', style: TextStyles.h3),
            Text(product.description, style: TextStyles.b1),
            const SizedBox(height: 16.0),
            const Text('Satuan:', style: TextStyles.b1),
            Text(product.unit,
                style: TextStyles.h4.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),
            const Text('Harga Jual:', style: TextStyles.b1),
            Text('Rp ${product.price.toStringAsFixed(0)}',
                style: TextStyles.h3.copyWith(
                    color: PrimaryColor.c8, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
