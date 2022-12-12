import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/profile/rating_form.dart';
import 'package:kembangin_mobile/pages/profile/ratings.dart';
import 'package:kembangin_mobile/utils/profile_fetch_data.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

class DoctorDetail extends StatefulWidget {
  const DoctorDetail({super.key, required this.id});
  final int id;

  @override
  DoctorDetailState createState() => DoctorDetailState();
}

class DoctorDetailState extends State<DoctorDetail> {
  void refreshWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    return (FutureBuilder(
        future: fetchDoctorProfile(widget.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else {
            return Column(
              children: [
                const Text("Rating"),
                Text(snapshot.data[0].ratingAverage.toString()),
                ButtonWidget(
                    width: 150,
                    text: const Text(
                      "Berikan Rating",
                      style: TextStyle(color: Colors.white),
                    ),
                    paddingVertical: 0,
                    paddingHorizontal: 0,
                    marginVertical: 0,
                    marginHorizontal: 0,
                    onPressed: () {
                      if (request.jsonData["id"] == null) {
                        toast(
                            context, true, "Anda harus login terlebih dahulu!");
                      } else if (request.jsonData["id"] == widget.id) {
                        toast(context, true,
                            "Anda tidak bisa memberi rating pada diri sendiri!");
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return RatingForm(id: widget.id);
                            });
                      }
                    }),
                RatingList(id: widget.id),
              ],
            );
          }
        }));
  }
}
