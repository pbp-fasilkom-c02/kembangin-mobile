import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kembangin_mobile/main.dart';
import 'package:kembangin_mobile/pages/bmicalculator/bmi_card.dart';
import 'package:kembangin_mobile/utils/bmi_fetch.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/pages/bmicalculator/bmi_card.dart';
import 'package:http/http.dart' as http;
import 'package:kembangin_mobile/models/bmi_model.dart';
import 'dart:convert';
import 'package:kembangin_mobile/pages/forum/forum_card.dart';
class BmiFormPage extends StatefulWidget {
  const BmiFormPage({super.key});

  @override
  State<BmiFormPage> createState() => _BmiFormPageState();
}
class _BmiFormPageState extends State<BmiFormPage> {
  

  final _formKey = GlobalKey<FormState>();
  int? weight;
  int? height;
  int? bmi;
  String? author;

  Future<void> onPressed(BuildContext context) async {
    // handle jika user belum login maka post as anonymous
    final request = context.read<CookieRequest>();
    author = request.jsonData['username'] == null
        ? "AnonymousUser"
        : "${request.jsonData['username']}";
      final response = await http.post(
      Uri.parse(
          'https://kembangin.up.railway.app/bmicalculator/add_calculate_flutter/'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'height': height,
        'weight': weight, 
        'author': author,   
      }));
  // ignore: use_build_context_synchronously
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const BmiFormPage()),);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: const TopNavbar(),
      bottomNavigationBar: const BottomNav(index: 3),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              borderRadius: const BorderRadius.all(Radius.circular(0)),
            ),
            margin: const EdgeInsets.only(top: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "< 18.5 (Under) || 18.5-24.9 (Normal) || > 24.9 (Over)",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Welcome back, ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // tampilkan username from cookie
              Text(
                request.jsonData['username'] == null
                    ? "AnonymousUser"
                    : "${request.jsonData['username']}",
                style: const TextStyle(
                    color: Color.fromARGB(255, 244, 77, 127),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
            ]),
          ),
          
          ButtonWidget(
            marginHorizontal: 100,
            marginVertical: 16,
            width: double.infinity,
            paddingVertical: 4,
            paddingHorizontal: 0,
            text: const Text(
              "(+) Hitung BMI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                        body: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                                    Text(
                                      "Hitung Bmi",
                                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "65",
                                      labelText: "Berat Badan (kg)",
                                      labelStyle: const TextStyle(
                                          color: Colors.red
                                      ),
                                      icon: const Icon(Icons.line_weight),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),                                      
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Berat Badan Tidak Boleh Kosong';
                                      }
                                      return null;
                                    },
                                    onChanged: (String? value) {
                                      setState((){
                                        weight = int.parse(value!);
                                      });                                      
                                    },
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "175",
                                      labelText: "Tinggi Badan (cm)",
                                      labelStyle: const TextStyle(
                                          color: Colors.red),
                                      icon: const Icon(Icons.height),
                                      // Menambahkan circular border agar lebih rapi

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Tinggi Badan Tidak Boleh Kosong';
                                      }
                                      return null;
                                    },
                                    onChanged: (String? value) {
                                      setState((){
                                        height = int.parse(value!);
                                      });                                      
                                    },                                  
                                  ),
                                ),
                                Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          backgroundColor: Colors.red[300],
                                          padding: const EdgeInsets.all(16.0),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          alignment: Alignment.center,
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            onPressed(context);                                          
                                          }
                                        },
                                        child: const Text("Calculate",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ),
                                    ),
                                    // make button back
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          backgroundColor: Colors.red[300],
                                          padding: const EdgeInsets.all(16.0),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          alignment: Alignment.center,
                                        ),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BmiFormPage()),
                                        ),
                                        child: const Text("Back",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ),
                                    ),
                              ],
                            ),
                            )
                        ));
                  });
            },
          ),
          // jika yang login anonymous maka ambil data json anonymous
          const BmiCard(),

          

          // jika yang login user maka ambil data json user
          
        ]),
      ),
    );
  }
}


