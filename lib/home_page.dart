import 'package:flutter/material.dart';
import 'package:toko_baju/database/database.dart';
import 'package:toko_baju/hardcode/data.dart';
import 'package:toko_baju/models/baju.dart';
import 'package:toko_baju/widgets/bajupage.dart';
import 'package:toko_baju/widgets/detail_view.dart';
import 'package:toko_baju/widgets/transaksi_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Baju> _baju;
  var _isLoading = false;

  Future _refresh() async {
    setState(() {
      _isLoading = true;
    });

    _baju = await Databasetoko.instance.getAllBaju();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _initDatabase() async {
    final database = Databasetoko.instance;
    for (Baju baju in hardcodedBajuData) {
      await database.insertBaju(baju);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refresh();
    _initDatabase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ageman"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => transaksiView(),
                      ));
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    )),
                Icon(Icons.account_circle_outlined, color: Colors.black),
                SizedBox(width: 8),
                Text("Nufus"),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
      body: bajuPage()
    );
  }
}
