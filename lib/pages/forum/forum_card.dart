import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/utils/delete_forum.dart';
import 'dart:convert';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/pages/forum/forum_detail.dart';
import 'package:kembangin_mobile/utils/forum_fetch.dart';

class ForumCard extends StatefulWidget {
  const ForumCard({
    super.key,
  });

  @override
  ForumCardState createState() => ForumCardState();
}

class ForumCardState extends State<ForumCard> {
  void refreshWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map res;
    final request = context.read<CookieRequest>();
    Future fut = fetchForum();

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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForumDetail(
                                    forumData: snapshot.data![
                                        snapshot.data!.length - index - 1])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          height: 120,
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot
                                              .data![snapshot.data!.length -
                                                  index -
                                                  1]
                                              .question,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              try {
                                                await deleteForum(
                                                        snapshot
                                                            .data![snapshot
                                                                    .data!
                                                                    .length -
                                                                index -
                                                                1]
                                                            .pk,
                                                        request.jsonData[
                                                            'username'])
                                                    .then((response) => {
                                                          res = jsonDecode(
                                                              response),
                                                          if (res['status'] ==
                                                              true)
                                                            {
                                                              refreshWidget(),
                                                              toast(
                                                                  context,
                                                                  false,
                                                                  res['message'])
                                                            }
                                                          else
                                                            {
                                                              toast(
                                                                  context,
                                                                  true,
                                                                  res['message'])
                                                            }
                                                        });
                                              } catch (e) {
                                                toast(context, true,
                                                    "Kamu belum login!");
                                              }
                                              // print(request.jsonData);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ]),
                                  Row(
                                    children: [
                                      Text(snapshot
                                          .data![
                                              snapshot.data!.length - index - 1]
                                          .description),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const Text("Dibuat oleh "),
                                      Text(
                                        "${snapshot.data![snapshot.data!.length - index - 1].isDoctor ? "dr. " : ""}${snapshot.data![snapshot.data!.length - index - 1].author}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ),
                    )));
          }
        }));
  }
}