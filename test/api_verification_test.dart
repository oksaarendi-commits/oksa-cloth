import 'package:flutter_test/flutter_test.dart';
import 'package:oksacloth/models/product.dart';
import 'package:oksacloth/services/api_service.dart';

void main() {
  test('ApiService CRUD verification', () async {
    final apiService = ApiService();

    // 1. Fetch
    final products = await apiService.getProducts();
    expect(products, isA<List<Product>>());
    print('Fetched ${products.length} products');

    // 2. Create
    final newProduct = Product(
      id: '',
      nama: 'Test Flutter Product',
      harga: 100,
      stok: 10,
      kategori: 'Test',
      deskripsi: 'Test description',
      imageUrl: 'https://example.com/image.jpg',
    );
    final createdProduct = await apiService.createProduct(newProduct);
    expect(createdProduct.nama, 'Test Flutter Product');
    expect(createdProduct.id, isNotEmpty);
    print('Created product with ID: ${createdProduct.id}');

    // 3. Update
    final updatedProduct = createdProduct.copyWith(nama: 'Updated Test Flutter Product');
    final result = await apiService.updateProduct(updatedProduct);
    expect(result.nama, 'Updated Test Flutter Product');
    print('Updated product');

    // 4. Delete
    await apiService.deleteProduct(createdProduct.id);
    print('Deleted product');
  });
}
