import 'package:flutter/material.dart';
// import 'dart:html';
import 'package:kembangin_mobile/pages/anak/rekomendasi.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:kembangin_mobile/widgets/bottom_nav.dart';

import 'package:kembangin_mobile/widgets/top_nav.dart';

class AddRekomendasiPage extends StatelessWidget {
  AddRekomendasiPage({
    super.key,
  });

  final namaBarangController = TextEditingController();
  final deskripsiController = TextEditingController();
  final hargaController = TextEditingController();
  final urlController = TextEditingController();
  final gambarController = TextEditingController();

  String nama_barang = "";
  String deskripsi = "";
  String harga_barang = "";
  String gambar = "";
  String url = "";

  @override
  Widget build(BuildContext context) {
    var dataRekomendasi;
    final request = context.read<CookieRequest>();

    return Scaffold(
        appBar: const TopNavbar(),
        bottomNavigationBar: const BottomNav(
          index: 2,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Tambah Rekomendasi",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InputField(
                        prefixIcon: Icon(
                          Icons.question_mark,
                          size: 30,
                          color: Colors.red.shade200,
                        ),
                        hintText: "Nama Barang",
                        controller: namaBarangController,
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputField(
                        prefixIcon: Icon(Icons.description_outlined,
                            size: 30, color: Colors.red.shade200),
                        hintText: "Harga Barang",
                        controller: hargaController,
                        isPassword: false,
                      ),
                      InputField(
                        prefixIcon: Icon(Icons.description_outlined,
                            size: 30, color: Colors.red.shade200),
                        hintText: "Deskripsi Barang",
                        controller: deskripsiController,
                        isPassword: false,
                      ),
                      InputField(
                        prefixIcon: Icon(Icons.description_outlined,
                            size: 30, color: Colors.red.shade200),
                        hintText: "URL",
                        controller: urlController,
                        isPassword: false,
                      ),
                      InputField(
                        prefixIcon: Icon(Icons.description_outlined,
                            size: 30, color: Colors.red.shade200),
                        hintText: "URL Gambar",
                        controller: gambarController,
                        isPassword: false,
                      ),
                      ButtonWidget(
                          marginHorizontal: 40,
                          marginVertical: 25,
                          width: double.infinity,
                          text: const Text(
                            "Add",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          paddingVertical: 8,
                          paddingHorizontal: 0,
                          onPressed: () async {
                            nama_barang = namaBarangController.text;
                            deskripsi = deskripsiController.text;
                            harga_barang = hargaController.text;
                            url = urlController.text;
                            gambar = gambarController.text;

                            final response = await request.post(
                                "https://kembangin.up.railway.app/rekomendasi/add/",
                                {
                                  'nama_barang': nama_barang,
                                  'deskripsi': deskripsi,
                                  'harga_barang': harga_barang,
                                  'url': url,
                                  'gambar': gambar,
                                });

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyRekomendasiPage()));
                          }),
                    ]),
              ),
            ],
          ),
        ));
  }
}
