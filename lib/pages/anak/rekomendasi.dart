import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/anak/rekomendasi_add.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/pages/auth/login.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import '../../models/rekomendasi_model.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import '../../utils/rekomendasi_fetch.dart';

// Detail Page untuk menampilkan detail data MyWatchList
class DetailPage extends StatelessWidget {
  const DetailPage(
      {super.key,
      required this.gambar,
      required this.namaBarang,
      required this.hargaBarang,
      required this.deskripsi,
      required this.url});
  final String gambar;
  final String namaBarang;
  final String hargaBarang;
  final String deskripsi;
  final String url;

  @override
  Widget build(BuildContext context) {
    var dataRekomendasi;
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Detail'),
        // ),
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image.network(gambar, width: 300, height: 300),
            Row(
              children: [
                SizedBox(width: 15, height: 25),
                Flexible(
                    child: Text(namaBarang,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 15, height: 25),
                Text(hargaBarang, style: TextStyle(fontSize: 20)),
              ],
            ),
            Row(children: [
              SizedBox(width: 15, height: 25),
              Text('Deskripsi: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
            Row(
              children: [
                SizedBox(width: 15, height: 25),
                Flexible(child: Text(deskripsi, style: TextStyle(fontSize: 20)))
              ],
            ),
            ButtonWidget(
              marginHorizontal: 40,
              marginVertical: 25,
              width: double.infinity,
              text: const Text(
                "Back",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              paddingVertical: 8,
              paddingHorizontal: 0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}

class MyRekomendasiPage extends StatefulWidget {
  const MyRekomendasiPage({super.key});

  @override
  _MyRekomendasiPageState createState() => _MyRekomendasiPageState();
}

class _MyRekomendasiPageState extends State<MyRekomendasiPage> {
  late final Future _getRekomendasiAsync;

  @override
  void initState() {
    super.initState();
    _getRekomendasiAsync = fetchRekomendasi();
  }

  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.grey;
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: const TopNavbar(),
      bottomNavigationBar: const BottomNav(
        index: 2,
      ),
      body: FutureBuilder(
          future: _getRekomendasiAsync,
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (request.jsonData['username'] == null) {
              return const Center(
                  child: Text(
                "Silahkan login terlebih dahulu :)",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ));
            } else {
              if (request.jsonData['is_doctor']) {
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddRekomendasiPage()),
                    );
                  },
                  tooltip: 'Tambah Rekomendasi',
                  child: const Icon(Icons.add),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text(
                    "Belum ada rekomendasi :(",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      gambar:
                                          snapshot.data![index].fields.gambar,
                                      namaBarang: snapshot
                                          .data![index].fields.namaBarang,
                                      hargaBarang: snapshot
                                          .data![index].fields.hargaBarang,
                                      deskripsi: snapshot
                                          .data![index].fields.deskripsi,
                                      url: snapshot.data![index].fields.url,
                                    )),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.red.shade900,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 2.0)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                  "${snapshot.data![index].fields.gambar}"),
                              const SizedBox(height: 10),
                              Text(
                                "${snapshot.data![index].fields.namaBarang}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )));
              }
            }
          }),
    );
  }
}
