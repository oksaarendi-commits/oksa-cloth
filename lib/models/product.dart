class Product {
  final String id;
  final String nama;
  final String imageUrl;
  final int harga;
  final int stok;
  final String kategori;
  final String deskripsi;

  Product({
    required this.id,
    required this.nama,
    required this.imageUrl,
    required this.harga,
    required this.stok,
    required this.kategori,
    required this.deskripsi,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      nama: json['nama'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      harga: json['harga'] != null
          ? (json['harga'] is int ? json['harga'] : int.tryParse(json['harga'].toString()) ?? 0)
          : 0,
      stok: json['stok'] != null
          ? (json['stok'] is int ? json['stok'] : int.tryParse(json['stok'].toString()) ?? 0)
          : 0,
      kategori: json['kategori'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'imageUrl': imageUrl,
      'harga': harga,
      'stok': stok,
      'kategori': kategori,
      'deskripsi': deskripsi,
    };
  }

  Product copyWith({
    String? id,
    String? nama,
    String? imageUrl,
    int? harga,
    int? stok,
    String? kategori,
    String? deskripsi,
  }) {
    return Product(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      imageUrl: imageUrl ?? this.imageUrl,
      harga: harga ?? this.harga,
      stok: stok ?? this.stok,
      kategori: kategori ?? this.kategori,
      deskripsi: deskripsi ?? this.deskripsi,
    );
  }
}
