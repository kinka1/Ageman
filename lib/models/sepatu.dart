class Sepatu {
  final String name;
  final String descripsi;
  final String imageUrl;
  final int harga;

  Sepatu({
    required this.name,
    required this.descripsi,
    required this.imageUrl,
    required this.harga,
  });
}

var sepatuList = [
  Sepatu(name: 'Police Denim', descripsi: 'kemeja' , imageUrl: 'https://partojambe.com/asset/foto_produk/kaos_kerah.jpeg', harga: 150000),
  Sepatu(name: 'Police Denim', descripsi: 'kaos' , imageUrl: 'https://partojambe.com/asset/foto_produk/kaos_kerah.jpeg', harga: 100000),
  Sepatu(name: 'Police Denim', descripsi: 'flanel' , imageUrl: 'https://partojambe.com/asset/foto_produk/kaos_kerah.jpeg', harga: 160000),

];