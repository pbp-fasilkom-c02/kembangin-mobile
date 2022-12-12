import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/utils/delete_forum.dart';
import 'dart:convert';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/pages/forum/forum_detail.dart';
import 'package:kembangin_mobile/utils/forum_fetch.dart';
import 'package:kembangin_mobile/utils/truncate_string.dart';

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
                          height: 140,
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            truncateWithEllipsis(
                                                40,
                                                snapshot
                                                    .data![
                                                        snapshot.data!.length -
                                                            index -
                                                            1]
                                                    .question),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.red,
                                                      offset: Offset(0, -5))
                                                ],
                                                color: Colors.transparent,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.red,
                                                decorationThickness: 2,
                                                fontSize: 20),
                                          ),
                                        ),
                                        request.jsonData['username'] ==
                                                snapshot
                                                    .data![
                                                        snapshot.data!.length -
                                                            index -
                                                            1]
                                                    .author
                                            ? IconButton(
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
                                            : const Text("")
                                      ]),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(truncateWithEllipsis(
                                            35,
                                            snapshot
                                                .data![snapshot.data!.length -
                                                    index -
                                                    1]
                                                .description)),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Dibuat oleh "),
                                          Text(
                                            "${snapshot.data![snapshot.data!.length - index - 1].isDoctor ? "dr. " : ""}${snapshot.data![snapshot.data!.length - index - 1].author}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                snapshot
                                                    .data![
                                                        snapshot.data!.length -
                                                            index -
                                                            1]
                                                    .replies
                                                    .length
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(
                                                  Icons.chat_bubble_outline,
                                                  color: Colors.red,
                                                  size: 20),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot
                                                    .data![
                                                        snapshot.data!.length -
                                                            index -
                                                            1]
                                                    .upvote
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(Icons.arrow_circle_up,
                                                  color: Colors.red, size: 20),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot
                                                    .data![
                                                        snapshot.data!.length -
                                                            index -
                                                            1]
                                                    .downvote
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(
                                                  Icons.arrow_circle_down,
                                                  color: Colors.red,
                                                  size: 20),
                                            ],
                                          )
                                        ],
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
