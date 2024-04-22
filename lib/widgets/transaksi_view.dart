import 'package:flutter/material.dart';
import 'package:toko_baju/database/database.dart';
import 'package:toko_baju/home_page.dart';
import 'package:toko_baju/models/transaksi.dart';

class transaksiView extends StatefulWidget {
  const transaksiView({super.key});

  @override
  State<transaksiView> createState() => _transaksiViewState();
}

class _transaksiViewState extends State<transaksiView> {
  final database = Databasetoko.instance.database;
  List<Transaksi> TransaksiList = [];

  Future<int> pembayaran() async {
    final unpaidTransactions = TransaksiList.where((transaksi) => transaksi.status != 'Selesai').toList();
    final totalPayment = unpaidTransactions.fold(0, (prev, current) => prev + current.harga);
    return totalPayment;
  }
  @override
  void initState() {
    super.initState();
    database.then((value) async {
      List<Map<String, dynamic>> result = await value.query(tabelTransaksi);
      TransaksiList = result.map((e) => Transaksi.fromJson(e)).toList();
      setState(() {});
    });
  }

  showAlertDialog(BuildContext context, int idTransaksi) {
    Widget okButton = TextButton(
      child: Text("Yakin"),
      onPressed: () async {
        await database.then((value) => value.delete(tabelTransaksi, where: '${TransaksiFields.id} = ?', whereArgs: [idTransaksi]));
        TransaksiList.removeWhere((element) => element.id == idTransaksi);
        setState(() {});
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Peringatan !"),
      content: Text("Anda yakin akan menghapus ?"),
      actions: [okButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Future<void> payTransaksi() async {
    final db = await database;
    // Update status transaksi menjadi "Selesai"
    await db.update(
      tabelTransaksi,
      {TransaksiFields.status: 'Selesai'},
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Ganti BajuPage dengan nama halaman yang sesuai
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Terimakasih Telah Melakukan Pembayaran'),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Keranjang"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: TransaksiList.length,
              itemBuilder: (context, index) {
                final Transaksi transaksi = TransaksiList[index];
                return ListTile(
                  leading: Image.asset(transaksi.imageUrl, width: 100),
                  title: Text(
                    transaksi.nama,
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(transaksi.status),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showAlertDialog(context, transaksi.id!);
                        },
                      ),

                    ],
                  ),
                  subtitle: Text(
                    "Rp ${transaksi.harga}",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<int>(
                  future: pembayaran(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Text(
                      'Total pembayaran : Rp ${snapshot.data?.toString() ?? ''}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: payTransaksi,
                  child: Text('Bayar'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white,
                    ),

                  ),

                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}