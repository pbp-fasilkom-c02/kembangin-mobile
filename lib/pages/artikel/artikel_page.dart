import 'package:kembangin_mobile/utils/artikel_fetch_data.dart';
import 'package:kembangin_mobile/drawer.dart';
import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_detail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyArtikelPage extends StatefulWidget {
  const MyArtikelPage({super.key});

  @override
  State<MyArtikelPage> createState() => _MyArtikelPageState();
}

class _MyArtikelPageState extends State<MyArtikelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Artikel")),
        drawer: MyDrawer(),
        body: FutureBuilder(
            future: fetchMyArtikel(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Artikel kosong",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black, blurRadius: 1.0)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                    title: Text(
                                        '${snapshot.data![index].fields.title}'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowWatchListDetailsPage(
                                                    watchlistItem:
                                                        snapshot.data![index])),
                                      );
                                    }),
                                Text(
                                    '${snapshot.data![index].fields.description}'),
                                Text('${snapshot.data![index].fields.upvote}'),
                                Text(
                                    '${snapshot.data![index].fields.downvote}'),
                                Text('${snapshot.data![index].fields.photo}'),
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
