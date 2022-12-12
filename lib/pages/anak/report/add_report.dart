import 'package:flutter/material.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final umurController = TextEditingController();
  final tinggiController = TextEditingController();
  final beratController = TextEditingController();
  final perkembanganController = TextEditingController();

  String nama = "";
  String umur = "";
  String tinggi = "";
  String berat = "";
  String? makan;
  String? minum;
  List<String> tingkatan = [
    'Tidak baik',
    'Kurang baik',
    'Cukup baik',
    'Sangat baik'
  ];
  String perkembangan = "";

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    void clear() {
      namaController.clear();
      umurController.clear();
      tinggiController.clear();
      beratController.clear();
      perkembanganController.clear();
    }

    return Scaffold(
        appBar: const TopNavbar(),
        bottomNavigationBar: const BottomNav(
          index: 2,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Tambah Catatan Baru",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 50,
                                      offset: Offset(0, 5),
                                      spreadRadius: -36)
                                ]),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                                controller: namaController,
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xffA6B0BD)),
                                    hintText: "Nama Anak",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.child_care,
                                        size: 30, color: Colors.red.shade200),
                                    prefixIconConstraints:
                                        const BoxConstraints(minWidth: 75),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                onChanged: (String? value) {
                                  setState(() {
                                    nama = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    nama = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama anak tidak boleh kosong!';
                                  }
                                  return null;
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 50,
                                      offset: Offset(0, 5),
                                      spreadRadius: -36)
                                ]),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                                controller: umurController,
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xffA6B0BD)),
                                    hintText: "Umur Anak",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.pin,
                                        size: 30, color: Colors.red.shade200),
                                    prefixIconConstraints:
                                        const BoxConstraints(minWidth: 75),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                onChanged: (String? value) {
                                  setState(() {
                                    umur = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    umur = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Umur anak tidak boleh kosong!';
                                  }
                                  return null;
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 50,
                                      offset: Offset(0, 5),
                                      spreadRadius: -36)
                                ]),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                                controller: tinggiController,
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xffA6B0BD)),
                                    hintText: "Tinggi Badan Anak",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.square_foot,
                                        size: 30, color: Colors.red.shade200),
                                    prefixIconConstraints:
                                        const BoxConstraints(minWidth: 75),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                onChanged: (String? value) {
                                  setState(() {
                                    tinggi = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    tinggi = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tinggi badan anak tidak boleh kosong!';
                                  }
                                  return null;
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 50,
                                      offset: Offset(0, 5),
                                      spreadRadius: -36)
                                ]),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                                controller: beratController,
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xffA6B0BD)),
                                    hintText: "Berat Badan Anak",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.scale,
                                        size: 30, color: Colors.red.shade200),
                                    prefixIconConstraints:
                                        const BoxConstraints(minWidth: 75),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                onChanged: (String? value) {
                                  setState(() {
                                    berat = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    berat = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Berat badan anak tidak boleh kosong!';
                                  }
                                  return null;
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 50,
                                      offset: Offset(0, 5),
                                      spreadRadius: -36)
                                ]),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: DropdownButtonFormField(
                                value: makan,
                                onChanged: (String? value) {
                                  makan = value!;
                                },
                                onSaved: (String? value) {
                                  makan = value!;
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tingkat makan harus dipilih!';
                                  }
                                  return null;
                                },
                                isExpanded: true,
                                items: tingkatan.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xffA6B0BD)),
                                    hintText: "Tingkat Makan Anak",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.restaurant,
                                        size: 30, color: Colors.red.shade200),
                                    prefixIconConstraints:
                                        const BoxConstraints(minWidth: 75),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 50,
                                      offset: Offset(0, 5),
                                      spreadRadius: -36)
                                ]),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: DropdownButtonFormField(
                                value: minum,
                                onChanged: (String? value) {
                                  minum = value!;
                                },
                                onSaved: (String? value) {
                                  minum = value!;
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tingkat minum harus dipilih!';
                                  }
                                  return null;
                                },
                                isExpanded: true,
                                items: tingkatan.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xffA6B0BD)),
                                    hintText: "Tingkat Minum Anak",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.local_drink,
                                        size: 30, color: Colors.red.shade200),
                                    prefixIconConstraints:
                                        const BoxConstraints(minWidth: 75),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 50,
                                      offset: Offset(0, 5),
                                      spreadRadius: -36)
                                ]),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                                minLines: 1,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: perkembanganController,
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xffA6B0BD)),
                                    hintText: "Perkembangan Anak",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.checklist,
                                        size: 30, color: Colors.red.shade200),
                                    prefixIconConstraints:
                                        const BoxConstraints(minWidth: 75),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                onChanged: (String? value) {
                                  setState(() {
                                    perkembangan = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    perkembangan = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Perkembangan anak tidak boleh kosong!';
                                  }
                                  return null;
                                }),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonWidget(
                              marginHorizontal: 40,
                              marginVertical: 5,
                              width: double.infinity,
                              text: const Text(
                                "Tambah",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              paddingVertical: 8,
                              paddingHorizontal: 0,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final response = await request.post(
                                      'https://kembangin.up.railway.app/report-progress/add-report-flutter/',
                                      {
                                        'name': nama,
                                        'age': umur,
                                        'height': tinggi,
                                        'weight': berat,
                                        'eat': makan,
                                        'drink': minum,
                                        'progress': perkembangan,
                                      }).then((response) => {
                                        if (response['status'])
                                          {
                                            toast(context, false,
                                                response['message']),
                                            clear(),
                                            setState(() {
                                              makan = null;
                                              minum = null;
                                            }),
                                          }
                                      });
                                }
                              }),
                          TextButton(
                            child: const Text("Kembali",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red)),
                            onPressed: () => {
                              Navigator.pop(context),
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                  ),
                ],
              ),
            )));
  }
}
