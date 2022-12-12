import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/utils/delete_forum_reply.dart';
import 'package:kembangin_mobile/pages/profile/profile_page.dart';

class ReplyCard extends StatefulWidget {
  final int forumPk;
  const ReplyCard({super.key, required this.forumPk});

  @override
  ReplyCardState createState() => ReplyCardState();
}

class ReplyCardState extends State<ReplyCard> {
  void refreshWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map res;
    final request = context.read<CookieRequest>();
    Future fut = request
        .get("https://kembangin.up.railway.app/forum/json/${widget.forumPk}");

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
                itemCount: snapshot.data!['replies'].length,
                itemBuilder: (data, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          height: 150,
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
                                          snapshot.data!['replies'][
                                              snapshot.data!['replies'].length -
                                                  index -
                                                  1]['comment'],
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )),
                                        IconButton(
                                            onPressed: () async {
                                              // try {
                                              await deleteReply(
                                                      snapshot.data![
                                                          'replies'][snapshot
                                                              .data!['replies']
                                                              .length -
                                                          index -
                                                          1]['pk'],
                                                      request
                                                          .jsonData['username'])
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
                                                            toast(context, true,
                                                                res['message'])
                                                          }
                                                      });
                                            },
                                            icon: const Icon(Icons.delete))
                                      ]),
                                  Row(
                                    children: [
                                      const Text("Dibuat oleh "),
                                      GestureDetector(
                                          onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage(
                                                          id: snapshot.data![
                                                              'replies'][snapshot
                                                                  .data![
                                                                      'replies']
                                                                  .length -
                                                              index -
                                                              1]['author_pk'],
                                                          username: snapshot
                                                                  .data![
                                                              'replies'][snapshot
                                                                  .data![
                                                                      'replies']
                                                                  .length -
                                                              index -
                                                              1]['author'],
                                                          isDoctor: snapshot
                                                                  .data![
                                                              'replies'][snapshot
                                                                  .data![
                                                                      'replies']
                                                                  .length -
                                                              index -
                                                              1]['is_doctor'],
                                                        )),
                                              ),
                                          child: Text(
                                            "dr. ${snapshot.data!['replies'][snapshot.data!['replies'].length - index - 1]['author']}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ),
                    ));
          }
        }));
  }
}
