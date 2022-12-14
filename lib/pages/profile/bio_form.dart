import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/profile/profile_detail.dart';
import 'package:kembangin_mobile/pages/profile/profile_page.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BioForm extends StatefulWidget {
  const BioForm({super.key, required this.id});
  final int id;

  @override
  State<BioForm> createState() => _BioFormState();
}

class _BioFormState extends State<BioForm> {
  final _formKey = GlobalKey<FormState>();
  String _newbio = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Ubah Bio'), backgroundColor: Colors.red),
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
                        labelText: "Bio",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _newbio = value!;
                        });
                      },
                    ),
                  ),
                  ButtonWidget(
                      width: 100,
                      text: const Text(
                        "Ubah",
                        style: TextStyle(color: Colors.white),
                      ),
                      paddingVertical: 0,
                      paddingHorizontal: 0,
                      marginVertical: 0,
                      marginHorizontal: 0,
                      onPressed: () async {
                        final response = await http.post(
                            Uri.parse(
                                'https://kembangin.up.railway.app/user_profile/change_bio/${widget.id}'),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: jsonEncode(<String, dynamic>{
                              'bio': _newbio,
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
