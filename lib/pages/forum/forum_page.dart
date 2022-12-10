import 'package:flutter/material.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kembangin_mobile/pages/forum/forum_card.dart';

// ignore: must_be_immutable
class ForumPage extends HookWidget {  // hookwidget berfungsi untuk 
  ForumPage({super.key});

  final pertanyaanController = TextEditingController();
  final deskripsiController = TextEditingController();

  String pertanyaan = "";
  String deskripsi = "";
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    void clear() {
      // Clean up the controller when the widget is disposed.
      pertanyaanController.clear();
      deskripsiController.clear();

      // super.dispose();
    }
    // data = useState(null);

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
                      const Text(
                        "Forum Konsultasi",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InputField(
                        prefixIcon: Icon(
                          Icons.question_mark,
                          size: 30,
                          color: Colors.red.shade200,
                        ),
                        hintText: "Pertanyaan",
                        controller: pertanyaanController,
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputField(
                        prefixIcon: Icon(Icons.description_outlined,
                            size: 30, color: Colors.red.shade200),
                        hintText: "Deskripsi",
                        controller: deskripsiController,
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
                            pertanyaan = pertanyaanController.text;
                            deskripsi = deskripsiController.text;
                            if (request.jsonData['username'] != null) {
                              final response = await request.post(
                                  "https://kembangin.up.railway.app/forum/add",
                                  {
                                    'question': pertanyaan,
                                    'description': deskripsi
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
                      const ForumCard(),
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
