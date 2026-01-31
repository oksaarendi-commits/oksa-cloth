import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';
import '../../utils/constants.dart';

class AdminReportScreen extends StatelessWidget {
  const AdminReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.slate900, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Sales Report', style: TextStyle(color: AppColors.slate900, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today_outlined, color: AppColors.slate900, size: 20), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Admin Dashboard', style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold)),
            const Text('oksa.cloth', style: TextStyle(color: AppColors.slate900, fontSize: 32, fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildStatCard('REVENUE', '\$12,450.00', Icons.payments, Colors.blue),
                const SizedBox(width: 16),
                _buildStatCard('ITEMS SOLD', '432', Icons.shopping_bag, Colors.indigo),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.slate100)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Revenue Forecast', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBar(40, false),
                        _buildBar(60, false),
                        _buildBar(85, true),
                        _buildBar(45, false),
                        _buildBar(70, false),
                        _buildBar(55, false),
                        _buildBar(90, false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'].map((d) => Text(d, style: const TextStyle(color: AppColors.slate400, fontSize: 9, fontWeight: FontWeight.bold))).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Recent Sales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            _buildSaleItem('Aiden Pearce', '2 mins ago', '+\$120.00', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAZkB1XGbMQGDXqAmzNqK9KbhKDfeGpm6eDtWCFD0t7H7GVPoBkVkW_Z8KJmJ6OxGy2_VKYlH9G4U-ogH4Nhu6sZwhz2dl4zQUDmMt5dz6BrXR3RQxwZ29FZ4iYmpNjFRPHf3Pea1acoxf_8SYJnzsPKV-fwy0JS1wut4HEqjmgDPMIvz0hJQAtTSyR4tU1BNztMU7b2EEj6O9pOjn_GOxLG_bN-NnHxfdbGSmDnabcw9SxUwTSLgxl6wihi75dG_0yrdFzjx1Eri8'),
            const SizedBox(height: 12),
            _buildSaleItem('Sarah Jenkins', '15 mins ago', '+\$45.00', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBSrh0v0IdfbsA8Q6CRFGLEc-QbZBd6hudtio7JRj5KIepNQvx8KGLAKhB39F57_VcBLnnHwMvyh_0hN2D4JKotUTzPNXDM21ZbmHWpDMA4my8bVxBeV-lbnIHCBCQ4mBGNf4B2x3Q3e1d9mJHfZUD1gz82jZh6nNi4-lvEv__CBOYkPe7yYrjjXCjPTcs6OUFsyJZ-erCmF28rlqzSDHbHkdg5RGR62tJgifa-dYz6_9WID11zIn1-A_LWn-W3T-Rj6DmfuXbKLHI'),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: AdminBottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/admin/inventory');
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.slate100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(color: AppColors.slate500, fontSize: 10, fontWeight: FontWeight.bold)),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(double heightFactor, bool isPrimary) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: heightFactor,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.slate100,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ),
    );
  }

  Widget _buildSaleItem(String name, String time, String price, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.slate100)),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(time, style: const TextStyle(color: AppColors.slate500, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
              const Text('PAID', style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
