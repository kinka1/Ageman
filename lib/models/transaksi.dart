const String tabelTransaksi = 'transaksi';

class TransaksiFields {
  static const String id = 'id';
  static const String nama = 'nama';
  static const String imageUrl = 'imageUrl';
  static const String harga = 'harga';
  static const String status = 'status';

}

class Transaksi {
  final int? id;
  final String nama;
  final String imageUrl;
  final int harga;
  final String status;

  Transaksi({
    required this.id,
    required this.nama,
    required this.imageUrl,
    required this.harga,
    required this.status,

  });

  Transaksi copy({
    int? id,
    String? nama,
    String? imageUrl,
    int? harga,
    String? status
  }) {
    return Transaksi(
        id: id,
        nama: nama ?? this.nama,
        imageUrl: imageUrl ?? this.imageUrl,
        harga: harga ?? this.harga,
        status: status ?? this.status
    );
  }

  static Transaksi fromJson(Map<String, Object?> json) {
    return Transaksi(
        id: json[TransaksiFields.id] as int?,
        nama: json[TransaksiFields.nama] as String,
        imageUrl: json[TransaksiFields.imageUrl] as String,
        harga: json[TransaksiFields.harga] as int,
      status: json[TransaksiFields.status] as String,
    );
  }

  Map<String, Object?> toJson() => {
        TransaksiFields.id: id,
        TransaksiFields.nama: nama,
        TransaksiFields.imageUrl: imageUrl,
        TransaksiFields.harga: harga,
    TransaksiFields.status: status
      };
}
