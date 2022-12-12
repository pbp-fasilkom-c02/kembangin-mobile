import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_page.dart';

// ignore: must_be_immutable
class ArtikelDetail extends StatelessWidget {
  final dynamic artikelData;
  ArtikelDetail({super.key, required this.artikelData});

  final komentarController = TextEditingController();

  String komentar = "";

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    void clear() {
      komentarController.clear();
    }

    return Scaffold(
        appBar: const TopNavbar(),
        bottomNavigationBar: const BottomNav(
          index: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ArtikelPage()))
                      },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.chevron_left_outlined,
                        color: Colors.red,
                      ),
                      Text(
                        "Kembali",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  )),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 5, color: Colors.red),
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(artikelData["fields"]["photo"]))),
                margin: const EdgeInsets.only(top: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await request.post(
                                'https://kembangin.up.railway.app/artikel/${artikelData['pk']}/vote/up',
                                {}).then((value) => print("berhasil"));
                            // ignore: use_build_context_synchronously
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ArtikelPage();
                            }));
                          },
                          icon: const Icon(Icons.thumb_up_rounded)),
                      Text(artikelData["fields"]["upvote"].toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await request.post(
                                'https://kembangin.up.railway.app/artikel/${artikelData['pk']}/vote/down',
                                {}).then((value) => print("berhasil"));
                            // ignore: use_build_context_synchronously
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ArtikelPage();
                            }));
                          },
                          icon: const Icon(Icons.thumb_down_alt_rounded)),
                      Text(artikelData["fields"]["downvote"].toString())
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  artikelData["fields"]["title"],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(artikelData["fields"]["description"]),
                const SizedBox(
                  height: 20,
                ),
              ])
            ],
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
