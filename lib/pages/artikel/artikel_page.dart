import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_card.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

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

  String title = "";
  String description = "";
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

    bool activeDoctor = false;
    bool active = false;
    String welcome = "Halo AnonymousUser";

    if (request.jsonData['username'] != null) {
      active = true;
      if (request.jsonData['is_doctor']) {
        activeDoctor = true;
        // ignore: prefer_interpolation_to_compose_strings
        welcome = "Halo, Dokter " + request.jsonData['username'];
      } else {
        // ignore: prefer_interpolation_to_compose_strings
        welcome = "Halo, Pasien " + request.jsonData['username'];
      }
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
                        active
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    welcome,
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  const Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Halo",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                        const SizedBox(
                          height: 20,
                        ),
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
                              title = judulController.text;
                              description = deskripsiController.text;
                              image = imageController.text;

                              if (request.jsonData['username'] != null) {
                                if (!request.jsonData["is_doctor"]) {
                                  toast(context, true,
                                      "Maaf Kamu Bukan Dokter :( \n Tidak Bisa Buat Artikel");
                                } else {
                                  print("jsondata");
                                  print(request.jsonData['username']);
                                  await request.post(
                                      'https://kembangin.up.railway.app/artikel/create-new-artikel/',
                                      {
                                        'title': title,
                                        'description': description,
                                        'photo': image,
                                      }).then((value) => print("berhasil"));
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ArtikelPage()),
                                  );
                                  // ignore: use_build_context_synchronously
                                  toast(context, false,
                                      "Berhasil Menambah Artikel");
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
