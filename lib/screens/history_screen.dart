import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../utils/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyItems = [
      {
        'id': '#OKS-8821',
        'date': 'Oct 24, 2023',
        'items': 3,
        'price': '\$124.00',
        'status': 'Processing',
        'color': Colors.amber,
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAWZOlnVl-YnQ8h-Sre-mK7nC_FKRCFy-7Ky9zrOD_BUyXARM0ijbWFlRHbtEGkcQ_rsAev4uyL2jNMm-yTNEBNsZziDaeF872-STNAZUtE4D7nOMg_NcHcyPhTCGo2sL-L0BhRGoF7qn_lmwQUPM5WyDlG0y6ZBDggJgI7l085dd7rIIVzZUo_JTkemKpHCaaIYpzlZ5OiLsdBJrPJHpcfjo9DdmYsIdRi-Vm4munRTmmU2Ti78ApfQRh8wtLW9SPPiCfe_dpcVk4'
      },
      {
        'id': '#OKS-8790',
        'date': 'Oct 18, 2023',
        'items': 1,
        'price': '\$59.00',
        'status': 'Delivered',
        'color': Colors.green,
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAlAPdgDBYshplvsEHyNv6dUB-OkSOaKP9W3qrG3wZCrujqYO6R6cs4nTsX0E_-v3EPv08TaqVi6GEmXruRDqhpRCY7OzNxXeNWtw6Da6QahdTQFnNwEiWMS-eqJrlrqhlw_1lzZrm3yI5ZGF-54qmSLKR5SiGIiKIc-MSGkfpziMXAT5Sy5BAOLxge6e0izt9Fv31JtKOZYfHrGjQnMrLys2ebFPqxZ4vX4ZaB2qeXO_czpVUdTaXwtdtxbxFTtb79CTZ18bwosF4'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        title: const Text(
          'Transaction History',
          style: TextStyle(color: AppColors.slate900, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search orders...',
                prefixIcon: const Icon(Icons.search, color: AppColors.slate400),
                filled: true,
                fillColor: AppColors.slate100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('RECENT ORDERS', style: TextStyle(color: AppColors.slate400, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                final item = historyItems[index];
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 1),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(image: NetworkImage(item['imageUrl'] as String), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order ${item['id']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.slate900)),
                            Text('${item['date']} • ${item['items']} items', style: const TextStyle(color: AppColors.slate500, fontSize: 12)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(width: 8, height: 8, decoration: BoxDecoration(color: item['color'] as Color, shape: BoxShape.circle)),
                                const SizedBox(width: 6),
                                Text((item['status'] as String).toUpperCase(), style: TextStyle(color: item['color'] as Color, fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item['price'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Icon(Icons.chevron_right, color: AppColors.slate200, size: 20),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: UserBottomNav(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/');
          if (index == 1) Navigator.pushReplacementNamed(context, '/catalog');
          if (index == 2) Navigator.pushReplacementNamed(context, '/cart');
        },
      ),
    );
  }
}
