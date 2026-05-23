import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../product_form/product_form_screen.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.inputBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  size: 48,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.skeleton,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'No products found',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your workspace is currently a clean slate. Start by adding your first product to the repository.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductFormScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
