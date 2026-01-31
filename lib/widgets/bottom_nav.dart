import 'package:flutter/material.dart';
import '../utils/constants.dart';

class UserBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const UserBottomNav({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: const Border(top: BorderSide(color: AppColors.slate100)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.slate400,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'SHOP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'HISTORY',
          ),
        ],
      ),
    );
  }
}

class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AdminBottomNav({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: const Border(top: BorderSide(color: AppColors.slate100)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          } else {
            onTap(index);
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.slate400,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'INVENTORY',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'REPORTS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'LOGOUT',
          ),
        ],
      ),
    );
  }
}
