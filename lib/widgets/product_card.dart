import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String merchantName;
  final String productUnit;
  final double price;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const ProductCard({
    required this.imageUrl,
    required this.productName,
    required this.productUnit,
    required this.merchantName,
    required this.price,
    this.onDelete,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(productName,
                              style: TextStyles.h4
                                  .copyWith(fontWeight: FontWeight.w500)),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[400]),
                            onPressed: onDelete,
                          ),
                        ],
                      ),
                      Text(merchantName, style: TextStyles.b1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Satuan: $productUnit', style: TextStyles.b1),
                          Text(
                            'Rp ${price.toStringAsFixed(0)}',
                            style: TextStyles.h4.copyWith(
                                color: PrimaryColor.c8,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
