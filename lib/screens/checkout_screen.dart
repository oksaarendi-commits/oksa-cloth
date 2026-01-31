import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: AppColors.slate900, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Shipping Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.slate100),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.home, color: AppColors.primary, size: 20),
                            SizedBox(width: 8),
                            Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'John Doe\n123 Fashion Avenue\nNew York, NY 10001',
                          style: TextStyle(color: AppColors.slate600, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuB1bLojpj7ehgCX1tdMWjmAg99ddt0blAMIwzFbEwTbZ-o_2y04muwhl2gC97wuGviPrZ7vnma3XMc7qLOpVKz-Lqc0_7WZTGQRoDy6GZ7qggy11tX4rCv3OXWogcOtG5PA8eqoN0NqLj7l94HNJiyPYc52M2xBiarbH1_2DNA4dnnagcFel1ptMmD3jroIEUw2F7Vd7_3iU6Z9KoeLnmehU9ZnVmgaoQ-e4cLKLyTr8XKyBDbZhhxdB2SiIxTKne19NKnaNt4RqPM'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Payment Method', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.03),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(child: Text('Pay', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 12))),
                      ),
                      const SizedBox(width: 16),
                      const Text('Apple Pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.slate100),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Subtotal', '\$165.00', false),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Shipping', 'FREE', true),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: AppColors.slate200),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Total', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      Text('\$165.00', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 24)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24).copyWith(bottom: 40),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              shadowColor: AppColors.primary.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.verified_user_outlined),
                SizedBox(width: 12),
                Text('CONFIRM PURCHASE', style: TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isEmerald) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.slate600, fontWeight: FontWeight.bold, fontSize: 14)),
        Text(value, style: TextStyle(color: isEmerald ? Colors.green : AppColors.slate900, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
