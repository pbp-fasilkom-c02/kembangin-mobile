import 'package:flutter/material.dart';
import 'package:kembangin_mobile/utils/profile_fetch_data.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/utils/bmi_fetch.dart';

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
    //Future fut = fetchNormalProfile(widget.id);

    return (FutureBuilder(
        future: fetchNormalProfile(widget.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else {
            if (!snapshot.hasData) {
              return const Text(
                ">:(",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              );
            } else {
              return const Text("1231231");
            }
          }
        }));
  }
}
