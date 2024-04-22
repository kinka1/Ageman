import 'package:flutter/material.dart';
import 'package:toko_baju/models/baju.dart';

import '../database/database.dart';
import '../models/transaksi.dart';

class detailView extends StatelessWidget {
  final Baju baju;

  const detailView({super.key, required this.baju});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(baju.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(baju.imageUrl),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  baju.harga.toString(),
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),

                Text(
                  "10RB+ Terjual",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
             Text(
              baju.name,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 16.0),
            const Row(
              children: [
                Text("Penilaian product",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Padding(
                  padding: EdgeInsets.only(left: 55) ,
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 16.0, color: Colors.yellow),
                      Icon(Icons.star, size: 16.0, color: Colors.yellow),
                      Icon(Icons.star, size: 16.0, color: Colors.yellow),
                      Icon(Icons.star, size: 16.0, color: Colors.yellow),
                      Icon(Icons.star, size: 16.0, color: Colors.yellow),
                    ],
                  ),
                ),
                Text('(36,7RB Ulasan)')
              ],
            ),
            const SizedBox(height: 15),
            const Text('Deskripsi : ', style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 20,),
            Text(
                baju.diskripsi), //deskirpsi
            const SizedBox(height: 16.0),

            SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Buat instance Transaksi berdasarkan data Baju yang dipilih
                    Transaksi transaksi = Transaksi(
                      id: baju.id, // Gunakan id Baju yang dipilih
                      imageUrl: baju.imageUrl,
                      harga: baju.harga, nama: baju.name, status: "Belum bayar"
                    );

                    // Simpan data Transaksi ke dalam tabel transaksi
                    await Databasetoko.instance.insertTransaksi(transaksi);

                    // Tampilkan snackbar atau pesan sukses setelah data berhasil disimpan
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Baju telah ditambahkan ke dalam keranjang.'),
                      ),
                    );
                  },
                  child: Text('Tambah ke Keranjang'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
