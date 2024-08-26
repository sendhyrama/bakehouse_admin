import 'package:bakehouse_admin/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../services/firestore_service.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/product_card.dart';

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
                // Filter the products based on the search query
                final filteredProducts = _searchQuery.isEmpty
                    ? products
                    : products.where((product) {
                        final productName = product.productName.toLowerCase();
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
                          return const SizedBox
                              .shrink(); // Do nothing while loading
                        }
                        if (snapshot.hasError) {
                          return const Text('Error loading merchant data');
                        }
                        final user = snapshot.data;
                        return ProductCard(
                          imageUrl: product.imageUrl,
                          productName: product.productName,
                          productUnit: product.productUnit,
                          merchantName:
                              user?.businessName ?? 'Unknown Merchant',
                          price: product.price,
                          onDelete: () {
                            // Handle delete action here
                          },
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(
                  child:
                      CircularProgressIndicator()), // Single circular progress indicator
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
