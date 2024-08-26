import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../providers/product_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/product_card.dart';
import '../../widgets/search_bar.dart';
import 'product_detail_page.dart';

final productsProvider = StreamProvider<List<Product>>((ref) {
  return FirestoreService().getProducts();
});

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  Future<void> _onDeleteProduct(BuildContext context, String productId) async {
    final confirmed = await _showConfirmationDialog(context);
    if (confirmed) {
      await ref.read(deleteProductProvider(productId).future);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil terhapus!')),
      );
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
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(productsProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Produk UMKM',
              style: TextStyles.h2.copyWith(color: Colors.white),
            ),
          ),
          backgroundColor: PrimaryColor.c8,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          SearchBarr(controller: _searchController, onSearch: _onSearch),
          Expanded(
            child: productsAsyncValue.when(
              data: (products) {
                final filteredProducts = _searchQuery.isEmpty
                    ? products
                    : products.where((product) {
                        final productName = product.name.toLowerCase();
                        return productName.contains(_searchQuery);
                      }).toList();

                if (filteredProducts.isEmpty) {
                  return Center(
                    child: Text(
                      'No products found.',
                      style: TextStyles.h3.copyWith(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return FutureBuilder<User?>(
                      future: FirestoreService().getUserById(product.userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        }
                        if (snapshot.hasError) {
                          return const Text('Error loading merchant data');
                        }
                        final user = snapshot.data;
                        return ProductCard(
                          imageUrl: product.imageUrl,
                          productName: product.name,
                          productUnit: product.unit,
                          merchantName:
                              user?.businessName ?? 'Unknown Merchant',
                          price: product.price,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  product: product,
                                  productId: product.id,
                                ),
                              ),
                            );
                          },
                          onDelete: () => _onDeleteProduct(context, product.id),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
