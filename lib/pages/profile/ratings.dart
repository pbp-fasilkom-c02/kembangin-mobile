import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/profile/profile_page.dart';
import 'package:kembangin_mobile/utils/profile_fetch_data.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/button.dart';

class RatingList extends StatefulWidget {
  const RatingList({super.key, required this.id});
  final int id;

  @override
  RatingListState createState() => RatingListState();
}

class RatingListState extends State<RatingList> {
  void refreshWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return FutureBuilder(
        future: fetchRating(widget.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 2.0)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                      id: snapshot.data![index].authorPk)),
                            ),
                            child: Text(
                              "${snapshot.data![index].authorIsDoctor ? "dr. " : ""}${snapshot.data![index].authorUsername}",
                            ),
                          ),
                          const Text("Rating:"),
                          Text("❤️" * snapshot.data![index].rating),
                          const Text("Komentar:"),
                          snapshot.data![index].comment == ""
                              ? const Text("Tidak ada komentar")
                              : Text(snapshot.data![index].comment),
                          ButtonWidget(
                              width: 120,
                              text: const Text(
                                "Hapus Rating",
                                style: TextStyle(color: Colors.white),
                              ),
                              paddingVertical: 0,
                              paddingHorizontal: 0,
                              marginVertical: 0,
                              marginHorizontal: 0,
                              onPressed: snapshot.data![index].authorPk !=
                                      request.jsonData["id"]
                                  ? () {
                                      toast(context, true,
                                          "Anda tidak bisa menghapus rating orang lain");
                                    }
                                  : () async {
                                      final response = await http.delete(
                                        Uri.parse(
                                            'https://kembangin.up.railway.app/user_profile/delete_rating_flutter/${snapshot.data![index].id}'),
                                      );

                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage(id: widget.id)),
                                      );
                                    })
                        ],
                      ),
                    ));
          }
        });
  }
}
