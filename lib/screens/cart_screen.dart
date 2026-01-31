import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    final cartItems = [
      {
        'name': 'Oksa Oversized Tee',
        'price': 45.00,
        'size': 'M',
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAqLO4Il1mrgecjC6KDWKSiIHwU-BMDcU36LGBdPoh1jF1-qjmTdDcY6fRqZI4Y1Zptb3vJJTlUuf-NT9gd3bAZcQgbpMJjOvg2J02YDvH31xzQgWbzyMkcIkHCfy1bIyf72p9ZQW7u2j-rmiBgMHeBwcyDK_2bURuQEyZpMBlkZDEWp-v2Hc6qQA_mefqR3albsRHipORoHnzb8VwxZgTZZJ2YjdGtQbIClAo-XXBsK-FUT7i3mHXIg2OKo79t9ovakrGgjm0RWco'
      },
      {
        'name': 'Midnight Cargo Pants',
        'price': 120.00,
        'size': 'L',
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4-v_I1YPbn5H5uEsczqI9bKiqkPLn1_NcFYWmX2vG7W0fAoEZkJCDXVx0TUkDWipOAa2fLg-HuQv2BHmJX6Zn3ew144xZarcJIaC177oq3DQZTMHYJfZwGZ_1MCsalMADsFMyYRZXsNrKWBi9Tvqof14a7SnvGlLbppFg5qEbU12X9dx8Keb6sgUio_Kmwc-GCwiOI4k1JvXwGklRJBdU1Clw5kDILvTxZBmo3-0QmXVreA20nRBJeLYMgbSq9qPRcfHLNlhfEkw'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: AppColors.slate900, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(item['imageUrl'] as String),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: AppColors.slate100),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] as String,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.slate900),
                            ),
                            Text(
                              'Size: ${item['size']}',
                              style: const TextStyle(color: AppColors.slate500, fontSize: 12),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currencyFormatter.format(item['price']),
                                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: AppColors.slate900),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.slate50,
                                    borderRadius: BorderRadius.circular(99),
                                    border: Border.all(color: AppColors.slate100),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildQtyBtn(Icons.remove, false),
                                      const SizedBox(width: 12),
                                      const Text('1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      const SizedBox(width: 12),
                                      _buildQtyBtn(Icons.add, true),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24).copyWith(bottom: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(top: BorderSide(color: AppColors.slate100)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 30, offset: const Offset(0, -10)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('TOTAL AMOUNT', style: TextStyle(color: AppColors.slate400, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                        Text('\$165.00', style: TextStyle(color: AppColors.slate900, fontSize: 32, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/checkout'),
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
                      children: const [
                        Text('PROCEED TO CHECKOUT', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1)),
                        SizedBox(width: 8),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, bool isPrimary) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.slate200,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: isPrimary ? Colors.white : AppColors.slate600, size: 16),
    );
  }
}
