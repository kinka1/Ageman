import 'package:flutter/material.dart';
import 'package:toko_baju/widgets/detail_view.dart';

import '../database/database.dart';
import '../models/baju.dart';

class bajuPage extends StatefulWidget {
  const bajuPage({super.key});

  @override
  State<bajuPage> createState() => _bajuPageState();
}

class _bajuPageState extends State<bajuPage> {
  late Future<List<Baju>> _bajuList;

  Future<List<Baju>> fetchBajuList() async {
    final database = await Databasetoko.instance.database;
    final bajuList = await database.query('baju');
    return bajuList.map((json) => Baju.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    _bajuList = fetchBajuList();
  }
  Widget build(BuildContext context) {
    return FutureBuilder<List<Baju>>(
      future: _bajuList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.custom(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 0.57,
            ),
            childrenDelegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final baju = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(baju.imageUrl, height: 200),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                        child: Text(
                          baju.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                        child: Text(
                          'Rp ${baju.harga}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => detailView(baju: baju),
                            ));
                          },
                          child: const Text('Detail'),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: snapshot.data!.length,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
