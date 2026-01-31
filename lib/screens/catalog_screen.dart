import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/product_card.dart';
import '../utils/constants.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _apiService.getProducts();
      if (mounted) {
        setState(() {
          _products = products;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _products.where((p) => p.nama.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'oksa.cloth',
          style: TextStyle(color: AppColors.slate900, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_bag_outlined, color: AppColors.slate700),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search items...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.slate400),
                    filled: true,
                    fillColor: AppColors.slate100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: ['All', 'Hoodies', 'Tees', 'Pants', 'Jackets'].map((cat) {
                    bool isSelected = cat == 'All';
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.slate100,
                        borderRadius: BorderRadius.circular(99),
                        boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))] : [],
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.slate600,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadProducts,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: filteredProducts[index]);
                },
              ),
            ),
      bottomNavigationBar: UserBottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/');
          if (index == 2) Navigator.pushNamed(context, '/cart');
          if (index == 3) Navigator.pushNamed(context, '/history');
        },
      ),
    );
  }
}
