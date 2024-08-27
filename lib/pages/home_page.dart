import 'package:bakehouse_admin/utils/colors.dart';
import 'package:bakehouse_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/stats_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalUMKMAsync = ref.watch(totalUMKMProvider);
    final totalCustomersAsync = ref.watch(totalCustomersProvider);
    final totalProductsAsync = ref.watch(totalProductsProvider);
    final totalCompletedOrdersAsync = ref.watch(totalCompletedOrdersProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Beranda',
              style: TextStyles.h2.copyWith(color: Colors.white),
            ),
          ),
          backgroundColor: PrimaryColor.c8,
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hello, Admin!', style: TextStyles.h2),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: PrimaryColor.c8, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people, color: PrimaryColor.c8),
                          SizedBox(width: 8),
                          Text('Total Pengguna', style: TextStyles.h3),
                        ],
                      ),
                      const SizedBox(height: 16),
                      totalUMKMAsync.when(
                        data: (totalUMKM) {
                          return totalCustomersAsync.when(
                            data: (totalCustomers) {
                              final totalUsers = totalUMKM + totalCustomers;
                              return Center(
                                child: Text(totalUsers.toString(),
                                    style: TextStyles.h1
                                        .copyWith(color: PrimaryColor.c8)),
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stack) => Center(
                              child: Text('Error: $error'),
                            ),
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stack) => Center(
                          child: Text('Error: $error'),
                        ),
                      ),
                      const Divider(
                        height: 32,
                        thickness: 1,
                        color: PrimaryColor.c8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          totalUMKMAsync.when(
                            data: (totalUMKM) => Column(
                              children: [
                                Text(totalUMKM.toString(),
                                    style: TextStyles.h3),
                                const SizedBox(height: 4),
                                const Text(
                                  'UMKM',
                                  style: TextStyles.h4,
                                ),
                              ],
                            ),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stack) => Text('Error: $error'),
                          ),
                          totalCustomersAsync.when(
                            data: (totalCustomers) => Column(
                              children: [
                                Text(totalCustomers.toString(),
                                    style: TextStyles.h3),
                                const SizedBox(height: 4),
                                const Text(
                                  'Customer',
                                  style: TextStyles.h4,
                                ),
                              ],
                            ),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stack) => Text('Error: $error'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: PrimaryColor.c8, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2, color: PrimaryColor.c8),
                          SizedBox(width: 8),
                          Text('Total Produk', style: TextStyles.h3),
                        ],
                      ),
                      const SizedBox(height: 16),
                      totalProductsAsync.when(
                        data: (totalProducts) => Center(
                          child: Text(
                            totalProducts.toString(),
                            style:
                                TextStyles.h1.copyWith(color: PrimaryColor.c8),
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stack) => Center(
                          child: Text('Error: $error'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: PrimaryColor.c8, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2, color: PrimaryColor.c8),
                          SizedBox(width: 8),
                          Text('Produk Terjual', style: TextStyles.h3),
                        ],
                      ),
                      const SizedBox(height: 16),
                      totalCompletedOrdersAsync.when(
                        data: (totalCompletedOrders) => Center(
                          child: Text(
                            totalCompletedOrders.toString(),
                            style:
                                TextStyles.h1.copyWith(color: PrimaryColor.c8),
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stack) => Center(
                          child: Text('Error: $error'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
