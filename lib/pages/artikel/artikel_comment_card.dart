import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_detail.dart';

class ArtikelComment extends StatefulWidget {
  const ArtikelComment({
    super.key,
  });

  @override
  ArtikelCommentState createState() => ArtikelCommentState();
}

class ArtikelCommentState extends State<ArtikelComment> {
  void refreshWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map res;
    final request = context.read<CookieRequest>();
    Future fut =
        request.get("https://kembangin.up.railway.app/artikel/comment/json");

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
                          height: 100,
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data[snapshot.data!.length -
                                            index -
                                            1]["fields"]["comment"],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Created-at: ",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data[snapshot.data!.length -
                                            index -
                                            1]["fields"]["created_at"],
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      )
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
