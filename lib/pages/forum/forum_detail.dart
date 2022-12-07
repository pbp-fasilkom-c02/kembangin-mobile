import 'package:flutter/material.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:kembangin_mobile/pages/forum/reply_card.dart';

// ignore: must_be_immutable
class ForumDetail extends StatelessWidget {
  final dynamic forumData;
  ForumDetail({super.key, required this.forumData});

  final komentarController = TextEditingController();

  String komentar = "";

  @override
  Widget build(BuildContext context) {
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
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        forumData['question'],
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(forumData['created_at'].toString().substring(0, 10)),
                      Text(
                        forumData['description'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                              int forum_id = forumData['pk'];
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
                      ReplyCard(forumPk: forumData['pk']),
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
