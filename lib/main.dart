import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/history_screen.dart';
import 'screens/admin/inventory_screen.dart';
import 'screens/admin/product_form_screen.dart';
import 'screens/admin/report_screen.dart';
import 'models/product.dart';

void main() {
  runApp(const OksaClothApp());
}

class OksaClothApp extends StatelessWidget {
  const OksaClothApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'oksa.cloth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.manropeTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/admin/edit-product') {
          final product = settings.arguments as Product?;
          return MaterialPageRoute(
            builder: (context) => AdminProductFormScreen(product: product),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const HomeScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/history': (context) => const HistoryScreen(),
        '/admin/inventory': (context) => const AdminInventoryScreen(),
        '/admin/add-product': (context) => const AdminProductFormScreen(),
        '/admin/report': (context) => const AdminReportScreen(),
      },
    );
  }
}
