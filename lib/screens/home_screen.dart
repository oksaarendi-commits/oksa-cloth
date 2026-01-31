import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/product_card.dart';
import '../utils/constants.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Product> _featuredProducts = [];
  bool _isLoading = true;

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
          _featuredProducts = products.take(4).toList();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.admin_panel_settings_outlined, color: AppColors.slate700),
          onPressed: () => Navigator.pushNamed(context, '/admin/inventory'),
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
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.accentOrange,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Promo Banner
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.accentOrange, Color(0xFFFFA366)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentOrange.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Spring Fresh Collection',
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Get up to 40% off on all new denim arrivals.',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, '/catalog'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.accentOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              elevation: 0,
                            ),
                            child: const Text('SHOP NOW', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(Icons.local_offer_outlined, size: 80, color: Colors.white24),
                    ),
                  ],
                ),
              ),
            ),
            // Featured Items Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Featured Items',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.slate800),
              ),
            ),
            const SizedBox(height: 16),
            // Featured Items Grid
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: _featuredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: _featuredProducts[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: UserBottomNav(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/catalog');
          if (index == 2) Navigator.pushNamed(context, '/cart');
          if (index == 3) Navigator.pushNamed(context, '/history');
        },
      ),
    );
  }
}
