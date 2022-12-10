import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_detail.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_page.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/utils/delete_artikel.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_card.dart';

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
                                        IconButton(
                                            onPressed: () async {
                                              print("masukkk");
                                              print(snapshot.data![
                                                  snapshot.data!.length -
                                                      index -
                                                      1]['pk']);
                                              await deleteArtikel(
                                                  snapshot.data![
                                                      snapshot.data!.length -
                                                          index -
                                                          1]['pk']);
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return const ArtikelPage();
                                              }));
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
                                  // const Spacer(),
                                ],
                              )),
                        ),
                      ),
                    )));
          }
        }));
  }
}
