import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _priceCtrl;
  bool _isSaving = false;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.product?.name ?? '');
    _priceCtrl = TextEditingController(
      text: widget.product != null
          ? widget.product!.price.toStringAsFixed(2)
          : '',
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final price = double.tryParse(_priceCtrl.text.trim());
    if (price == null) return;

    setState(() => _isSaving = true);
    final product = Product(
      id: widget.product?.id,
      name: _nameCtrl.text.trim(),
      price: price,
    );

    final provider = context.read<ProductProvider>();

    try {
      if (_isEditing) {
        await provider.updateProduct(product);
      } else {
        await provider.addProduct(product);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.errorMessage ?? 'Save failed',
            ),
            backgroundColor: AppColors.deleteRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(_isEditing ? 'Edit Product' : 'Add Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CATALOG MANAGEMENT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isEditing ? 'Modify Product' : 'Define New Product',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primaryNavy,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(
                      'Product Name',
                      uppercase: _isEditing,
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _nameCtrl,
                      hint: 'e.g. Enterprise Cloud Module',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Product name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildLabel('Price', uppercase: _isEditing),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _priceCtrl,
                      hint: '\$ 0.00',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Price is required';
                        }
                        if (double.tryParse(value.trim()) == null) {
                          return 'Enter a valid price';
                        }
                        return null;
                      },
                    ),
                    if (!_isEditing) ...[
                      const SizedBox(height: 20),
                      _infoBox(
                        'Ensure product pricing aligns with current regional tax regulations and platform fees.',
                      ),
                    ],
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryNavy,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              AppColors.primaryNavy.withValues(alpha: 0.5),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                _isEditing
                                    ? 'Save Changes'
                                    : 'Save Product',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed:
                            _isSaving ? null : () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryNavy,
                          side: BorderSide(
                            color: _isEditing
                                ? AppColors.primaryNavy
                                : AppColors.divider,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryNavy.withValues(
                              alpha: _isSaving ? 0.5 : 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_isEditing) ...[
                const SizedBox(height: 20),
                _infoBox(
                  'Updating product details will synchronize changes across all active inventory dashboards and analytics reports instantly.',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool uppercase = false}) {
    return Text(
      uppercase ? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: uppercase ? 11 : 14,
        fontWeight: FontWeight.w600,
        letterSpacing: uppercase ? 0.8 : 0,
        color: uppercase ? AppColors.primaryNavy : AppColors.textMuted,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textLight),
        filled: true,
        fillColor: AppColors.inputBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _infoBox(String message) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.infoBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 20,
            color: AppColors.primaryNavy,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 12,
                height: 1.45,
                color: AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
