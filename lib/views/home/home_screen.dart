import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/product_provider.dart';
import '../product_form/product_form_screen.dart';
import 'widgets/empty_state.dart';
import 'widgets/loading_state.dart';
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Consumer<ProductProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const LoadingState();
            }

            if (provider.hasError) {
              return _ErrorView(
                message: provider.errorMessage!,
                onRetry: () => provider.fetchProducts(),
              );
            }

            if (provider.isEmpty) {
              return const EmptyState();
            }

            return RefreshIndicator(
              color: AppColors.primaryNavy,
              onRefresh: provider.fetchProducts,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                itemCount: provider.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: provider.products[index]);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading || provider.isEmpty) {
            return const SizedBox.shrink();
          }
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductFormScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text(
              'ADD PRODUCT',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 56,
              color: AppColors.deleteRed,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textMuted),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
