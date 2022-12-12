import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/profile/bio_form.dart';
import 'package:kembangin_mobile/utils/profile_fetch_data.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key, required int this.id});
  final int id;

  @override
  PorfileDetailState createState() => PorfileDetailState();
}

class PorfileDetailState extends State<ProfileDetail> {
  void refreshWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    return (FutureBuilder(
        future: fetchNormalProfile(widget.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else {
            return Column(
              children: [
                snapshot.data[0].isDoctor
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "dr. ",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            snapshot.data[0].username,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      )
                    : Text(
                        snapshot.data[0].username,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                Text(
                  snapshot.data[0].email,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Telah membuat "),
                    Text(snapshot.data[0].postAmount.toString()),
                    const Text(" post di forum"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Telah mendapatkan "),
                    Text(snapshot.data[0].upvoteAmount.toString()),
                    const Text(" poin di forum")
                  ],
                ),
                const Text("Bio:"),
                Text(snapshot.data[0].bio == ""
                    ? "User belum menulis bio"
                    : snapshot.data[0].bio),
                ButtonWidget(
                    width: 150,
                    text: const Text(
                      "Ubah Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                    paddingVertical: 0,
                    paddingHorizontal: 0,
                    marginVertical: 0,
                    marginHorizontal: 0,
                    onPressed: request.jsonData["id"] != widget.id
                        ? () {
                            toast(context, true,
                                "Anda tidak bisa mengubah bio orang lain");
                          }
                        : () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const BioForm();
                                });
                          })
              ],
            );
          }
        }));
  }
}
