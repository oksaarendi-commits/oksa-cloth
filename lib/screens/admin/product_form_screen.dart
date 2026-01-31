import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../services/api_service.dart';
import '../../models/product.dart';

class AdminProductFormScreen extends StatefulWidget {
  final Product? product;
  const AdminProductFormScreen({Key? key, this.product}) : super(key: key);

  @override
  _AdminProductFormScreenState createState() => _AdminProductFormScreenState();
}

class _AdminProductFormScreenState extends State<AdminProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _descController;
  late TextEditingController _imageController;
  late TextEditingController _categoryController;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.nama ?? '');
    _priceController = TextEditingController(text: widget.product?.harga.toString() ?? '');
    _stockController = TextEditingController(text: widget.product?.stok.toString() ?? '');
    _descController = TextEditingController(text: widget.product?.deskripsi ?? '');
    _imageController = TextEditingController(text: widget.product?.imageUrl ?? '');
    _categoryController = TextEditingController(text: widget.product?.kategori ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descController.dispose();
    _imageController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final product = Product(
      id: widget.product?.id ?? '',
      nama: _nameController.text,
      harga: int.tryParse(_priceController.text) ?? 0,
      stok: int.tryParse(_stockController.text) ?? 0,
      deskripsi: _descController.text,
      imageUrl: _imageController.text,
      kategori: _categoryController.text,
    );

    try {
      if (widget.product == null) {
        await _apiService.createProduct(product);
      } else {
        await _apiService.updateProduct(product);
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.product != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEdit ? 'Edit Product' : 'Add Product',
          style: const TextStyle(color: AppColors.slate900, fontWeight: FontWeight.w800),
        ),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _saveProduct,
            child: const Text('Save', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: _isSubmitting
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showImageUrlDialog();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColors.slate50,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.slate200),
                        ),
                        child: _imageController.text.isNotEmpty && _imageController.text.startsWith('http')
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.network(_imageController.text, fit: BoxFit.cover),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                    child: const Icon(Icons.add_a_photo, color: AppColors.primary, size: 32),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text('Enter Image URL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildTextField('Product Name', _nameController, 'e.g. Oversized Cotton Tee'),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Price', _priceController, '0', keyboardType: TextInputType.number)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField('Stock', _stockController, '0', keyboardType: TextInputType.number)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildTextField('Category', _categoryController, 'e.g. Hoodies'),
                    const SizedBox(height: 24),
                    _buildTextField('Description', _descController, 'Describe the product...', maxLines: 5),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _saveProduct,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 10,
                          shadowColor: AppColors.primary.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline),
                            const SizedBox(width: 12),
                            Text(isEdit ? 'UPDATE PRODUCT' : 'SAVE PRODUCT', style: const TextStyle(fontWeight: FontWeight.w900)),
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

  Widget _buildTextField(String label, TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.slate100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.all(20),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'This field is required';
            if (keyboardType == TextInputType.number && int.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _showImageUrlDialog() {
    final controller = TextEditingController(text: _imageController.text);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Image URL'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'https://...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() {
                _imageController.text = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
