import 'package:flutter/material.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/utils/delete_artikel.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_detail.dart';

class ArtikelCard extends StatefulWidget {
  const ArtikelCard({
    super.key,
  });

  @override
  ArtikelCardState createState() => ArtikelCardState();
}

class ArtikelCardState extends State<ArtikelCard> {
  void refreshWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map res;
    final request = context.read<CookieRequest>();
    Future fut = request.get("https://kembangin.up.railway.app/artikel/json");

    return (FutureBuilder(
        future: fut,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else {
            return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (data, index) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArtikelDetail(
                                    artikelData: snapshot.data[
                                        snapshot.data!.length - index - 1])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          height: 240,
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${snapshot.data[snapshot.data!.length - index - 1]["fields"]["photo"]}'))),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data[snapshot.data!.length -
                                              index -
                                              1]["fields"]["description"],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () async {
                                                      if (request.jsonData[
                                                              "username"] !=
                                                          null) {
                                                        await request
                                                            .post('https://kembangin.up.railway.app/artikel/${snapshot.data![snapshot.data!.length - index - 1]['pk']}/vote/down', {}).then(
                                                                (value) => print(
                                                                    "berhasil"));
                                                        refreshWidget();
                                                        // ignore: use_build_context_synchronously
                                                        toast(context, false,
                                                            "Berhasil DownVote");
                                                      } else {
                                                        toast(context, true,
                                                            "Login terlebih dahulu!");
                                                      }
                                                    },
                                                    icon: const Icon(Icons
                                                        .thumb_down_alt_rounded)),
                                                Text(snapshot.data[snapshot
                                                            .data!.length -
                                                        index -
                                                        1]["fields"]["downvote"]
                                                    .toString())
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  if (request.jsonData[
                                                          "username"] !=
                                                      null) {
                                                    await request.post(
                                                        'https://kembangin.up.railway.app/artikel/${snapshot.data![snapshot.data!.length - index - 1]['pk']}/vote/up',
                                                        {}).then((value) => print("berhasil"));
                                                    refreshWidget();
                                                    // ignore: use_build_context_synchronously
                                                    toast(context, false,
                                                        "Berhasil Upvote");
                                                  } else {
                                                    toast(context, true,
                                                        "Kamu harus login terlebih dahulu!");
                                                  }
                                                },
                                                icon: const Icon(
                                                    Icons.thumb_up_rounded)),
                                            Text(snapshot.data[
                                                    snapshot.data!.length -
                                                        index -
                                                        1]["fields"]["upvote"]
                                                .toString())
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              // print("masukkk");
                                              // print(snapshot.data![
                                              //     snapshot.data!.length -
                                              //         index -
                                              //         1]['pk']);
                                              if (request
                                                      .jsonData["username"] !=
                                                  null) {
                                                if (request
                                                    .jsonData["is_doctor"]) {
                                                  await deleteArtikel(snapshot
                                                          .data![
                                                      snapshot.data!.length -
                                                          index -
                                                          1]['pk']);
                                                  refreshWidget();
                                                  // ignore: use_build_context_synchronously
                                                  toast(context, false,
                                                      "Berhasil Menghapus Artikel");
                                                } else {
                                                  toast(context, true,
                                                      "Hanya Dokter yang bisa menghapus artikel!");
                                                }
                                              } else {
                                                toast(context, true,
                                                    "Hanya Dokter yang bisa menghapus artikel!");
                                              }
                                            },
                                            icon: const Icon(Icons.delete))
                                      ]),
                                  Row(
                                    children: [
                                      Text(snapshot.data[snapshot.data!.length -
                                          index -
                                          1]["fields"]["title"])
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                    )));
          }
        }));
  }
}
