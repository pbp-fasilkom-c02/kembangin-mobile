import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/profile/profile_detail.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    return Scaffold(
      appBar: const TopNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [ProfileDetail(id: id), Text(id.toString())]),
            ),
          ],
        ),
      ),
    );
  }
}
