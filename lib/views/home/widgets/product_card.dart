import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../models/product.dart';
import '../../../providers/product_provider.dart';
import '../../product_form/product_form_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text(
          'Are you sure you want to delete "${product.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.deleteRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final provider = context.read<ProductProvider>();
    try {
      await provider.deleteProduct(product.id!);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              provider.errorMessage ?? 'Delete failed',
          ),
          backgroundColor: AppColors.deleteRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  formatPrice(product.price),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.priceBlue,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductFormScreen(product: product),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text(
                    'EDIT',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textMuted,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _confirmDelete(context),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text(
                    'DELETE',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.deleteRed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
