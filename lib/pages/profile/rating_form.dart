import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/profile/profile_detail.dart';
import 'package:kembangin_mobile/pages/profile/profile_page.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

class RatingForm extends StatefulWidget {
  const RatingForm({super.key, required this.id});
  final int id;

  @override
  State<RatingForm> createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  final _formKey = GlobalKey<FormState>();
  String _comment = "";
  var ratingChoices = <int>[1, 2, 3, 4, 5];
  int _rating = 1;

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
        appBar:
            AppBar(title: const Text('Rating'), backgroundColor: Colors.red),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Comment",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _comment = value!;
                        });
                      },
                    ),
                  ),
                  const Text("Rating"),
                  DropdownButton(
                    value: _rating,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: ratingChoices.map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newRating) {
                      setState(() {
                        _rating = newRating!;
                      });
                    },
                  ),
                  ButtonWidget(
                      width: 100,
                      text: const Text(
                        "Beri Rating",
                        style: TextStyle(color: Colors.white),
                      ),
                      paddingVertical: 0,
                      paddingHorizontal: 0,
                      marginVertical: 0,
                      marginHorizontal: 0,
                      onPressed: () async {
                        final response = await http.post(
                            Uri.parse(
                                'https://kembangin.up.railway.app/user_profile/handle_rating_flutter/${widget.id}'),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: jsonEncode(<String, dynamic>{
                              'author_pk': request.jsonData["id"],
                              'comment': _comment,
                              'rating': _rating
                            }));

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(id: widget.id)),
                        );
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
