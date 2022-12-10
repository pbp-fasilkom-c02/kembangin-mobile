// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kembangin_mobile/main.dart';
import 'package:kembangin_mobile/pages/bmicalculator/bmi_form2.dart';
import 'package:kembangin_mobile/utils/bmi_fetch.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:http/http.dart' as http;
import 'package:kembangin_mobile/models/bmi_model.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class BmiCard extends StatefulWidget {
  const BmiCard({super.key});

  @override
  BmiCardState createState() => BmiCardState();
}

class BmiCardState extends State<BmiCard> {
  void refreshWidget() {
    setState(() {});
  }

  // not fixed yet
  Future<http.Response> deleteBmi(int id) async {
    
    var url ='https://kembangin.up.railway.app/bmicalculator/delete_flutter/$id/';
    final http.Response response = await http.delete(
      Uri.parse(url, 
      ),


    );
    // print(response.body);
    return response;
  
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    final request = context.read<CookieRequest>();
    Map res;
    Future fut = fetchBmi();
    return (FutureBuilder(
      future: fut,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        } else {
          if (!snapshot.hasData) {
            return Column(
              children: const [
                Text(
                  "Tidak ada Data tersedia :(",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
                SizedBox(height: 8),
              ],
            );
          } else {
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (data, index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          height: 180,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "BMI: ${snapshot.data![snapshot.data!.length - index - 1].fields.bmi.toString()}"),
                                      IconButton(
                                        onPressed: () async {
                                          await deleteBmi(snapshot
                                              .data![snapshot.data!.length -
                                                  index -
                                                  1]
                                              .pk);
                                        
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const BmiFormPage();
                                          }));
                                          
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                      // belom handle delete
                                    ]),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text("Tinggi Badan: "),
                                    Text(
                                      snapshot
                                          .data![
                                              snapshot.data!.length - index - 1]
                                          .fields
                                          .height
                                          .toString(),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text("Berat Badan: "),
                                    Text(
                                      snapshot
                                          .data![
                                              snapshot.data!.length - index - 1]
                                          .fields
                                          .weight
                                          .toString(),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text("Dibuat pada: "),
                                    Text(
                                      formatter.format(DateTime.parse(snapshot
                                          .data![
                                              snapshot.data!.length - index - 1]
                                          .fields
                                          .date
                                          .toString())),
                                      // snapshot.data![snapshot.data!.length - index - 1].fields.date.toString(),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text("Author: "),
                                    Text(
                                      snapshot
                                          .data![
                                              snapshot.data!.length - index - 1]
                                          .fields
                                          .author,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))),
            );
          }
        }
      },
    ));
  }
}
