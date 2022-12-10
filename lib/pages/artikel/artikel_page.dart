import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_card.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:http/http.dart' as http;

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({
    super.key,
  });

  @override
  ArtikelPageState createState() => ArtikelPageState();
}

class ArtikelPageState extends State<ArtikelPage> {
  void refreshWidget() {
    setState(() {});
  }

  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  final imageController = TextEditingController();

  String judul = "";
  String deskripsi = "";
  String image = "";

  @override
  Widget build(BuildContext context) {
    Map res;
    final request = context.read<CookieRequest>();
    Future fut = request.get("https://kembangin.up.railway.app/artikel/json");

    void clear() {
      judulController.clear();
      deskripsiController.clear();
      imageController.clear();
    }

    return Scaffold(
        appBar: const TopNavbar(),
        bottomNavigationBar: const BottomNav(
          index: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Artikel",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InputField(
                          prefixIcon: const Icon(
                            Icons.title,
                            size: 30,
                            color: Colors.red,
                          ),
                          hintText: "Judul",
                          controller: judulController,
                          isPassword: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputField(
                          prefixIcon: const Icon(
                            Icons.description,
                            size: 30,
                            color: Colors.red,
                          ),
                          hintText: "Deskripsi",
                          controller: deskripsiController,
                          isPassword: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputField(
                          prefixIcon: const Icon(
                            Icons.image,
                            size: 30,
                            color: Colors.red,
                          ),
                          hintText: "Image",
                          controller: imageController,
                          isPassword: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonWidget(
                            marginHorizontal: 40,
                            marginVertical: 25,
                            width: double.infinity,
                            text: const Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            paddingVertical: 8,
                            paddingHorizontal: 0,
                            onPressed: () async {
                              judul = judulController.text;
                              deskripsi = deskripsiController.text;
                              image = imageController.text;

                              print(judul + " judulll");
                              print(deskripsi + " judulll");
                              print(image + " judulll");

                              if (request.jsonData['username'] != null) {
                                // print(request.jsonData['username']);
                                try {
                                  final response = await request.post(
                                      "https://kembangin.up.railway.app/artikel/create-new-artikel",
                                      {
                                        "title": "fdfdf",
                                        "description": "fdfdfd",
                                        "photo":
                                            "https://i.pinimg.com/564x/ed/f7/5d/edf75d68b04caccbfa3671b851c8d73d.jpg"
                                      }).then(
                                      (res) => {print("POST"), print(res)});
                                } catch (e) {
                                  print(e.toString());
                                }
                              } else {
                                toast(context, true,
                                    "Kamu harus login terlebih dahulu!");
                              }
                            }),
                        const ArtikelCard(),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
