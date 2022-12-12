import 'package:flutter/material.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:kembangin_mobile/pages/forum/reply_card.dart';
import 'package:kembangin_mobile/models/forum_model.dart';
import 'package:kembangin_mobile/pages/forum/forum_page.dart';
import 'package:kembangin_mobile/utils/handle_vote.dart';

// ignore: must_be_immutable
class ForumDetail extends StatefulWidget {
  final Forum forumData;

  ForumDetail({super.key, required this.forumData});

  @override
  State<ForumDetail> createState() => _ForumDetailState();
}

class _ForumDetailState extends State<ForumDetail> {
  final komentarController = TextEditingController();
  bool isPressed = false;
  int currentUpvote = 0;
  int currentDownvote = 0;
  String komentar = "";

  @override
  Widget build(BuildContext context) {
    int upvote = isPressed ? currentUpvote : widget.forumData.upvote;
    int downvote = isPressed ? currentDownvote : widget.forumData.downvote;

    final request = context.read<CookieRequest>();

    void clear() {
      // Clean up the controller when the widget is disposed.
      komentarController.clear();

      // super.dispose();
    }

    // data = useState(null);
    // print(forumData);
    return Scaffold(
        appBar: const TopNavbar(),
        bottomNavigationBar: const BottomNav(
          index: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [
                const SizedBox(
                  width: 40,
                ),
                TextButton(
                    onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForumPage(),
                            ),
                          )
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
              ]),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.forumData.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.forumData.createdAt
                          .toString()
                          .substring(0, 10)),
                      SafeArea(
                          minimum: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            widget.forumData.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_circle_up_outlined,
                                    color: Colors.red),
                                onPressed: () => {
                                      if (request.jsonData.isNotEmpty)
                                        {
                                          handleVote(widget.forumData.pk, "up")
                                              .then((value) => {
                                                    isPressed = true,
                                                    currentUpvote =
                                                        value['upvote'],
                                                    currentDownvote =
                                                        value['downvote'],
                                                    setState(() {
                                                      upvote = value['upvote'];
                                                      downvote =
                                                          value['downvote'];
                                                    }),
                                                  })
                                        }
                                      else
                                        {
                                          {
                                            toast(context, true,
                                                "Kamu belum login")
                                          }
                                        }
                                    }),
                            Text(
                              upvote.toString(),
                              style: TextStyle(color: Colors.red.shade700),
                            )
                          ]),
                          Row(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                      Icons.arrow_circle_down_outlined,
                                      color: Colors.red),
                                  onPressed: () => {
                                        if (request.jsonData.isNotEmpty)
                                          {
                                            handleVote(
                                                    widget.forumData.pk, "down")
                                                .then((value) => {
                                                      isPressed = true,
                                                      currentUpvote =
                                                          value['upvote'],
                                                      currentDownvote =
                                                          value['downvote'],
                                                      setState(() {
                                                        upvote =
                                                            value['upvote'];
                                                        downvote =
                                                            value['downvote'];
                                                      }),
                                                    })
                                          }
                                        else
                                          {
                                            toast(context, true,
                                                "Kamu belum login")
                                          }
                                      }),
                              Text(
                                downvote.toString(),
                                style: TextStyle(color: Colors.red.shade700),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        prefixIcon: Icon(
                          Icons.reply,
                          size: 30,
                          color: Colors.red.shade200,
                        ),
                        hintText: "Komentar",
                        controller: komentarController,
                        isPassword: false,
                      ),
                      ButtonWidget(
                          marginHorizontal: 40,
                          marginVertical: 25,
                          width: double.infinity,
                          text: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          paddingVertical: 8,
                          paddingHorizontal: 0,
                          onPressed: () async {
                            komentar = komentarController.text;
                            // print(komentar);
                            if (request.jsonData['username'] != null) {
                              int forum_id = widget.forumData.pk;
                              String user = request.jsonData['username'];
                              // print(user);
                              final response = await request.post(
                                  "https://kembangin.up.railway.app/forum/$forum_id/add-comment-flutter/$user",
                                  {
                                    "comment": komentar,
                                  }).then((response) => {
                                    if (response['status'])
                                      {clear(), rebuildAllChildren(context)}
                                    else
                                      {
                                        toast(
                                            context, true, response['message'])
                                      }
                                  });
                            } else {
                              toast(context, true,
                                  "Kamu harus login terlebih dahulu!");
                            }
                          }),
                      ReplyCard(forumPk: widget.forumData.pk),
                    ]),
              ),
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
