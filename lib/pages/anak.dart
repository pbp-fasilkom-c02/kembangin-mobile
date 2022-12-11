import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/report/report_page.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';

class AnakPage extends StatefulWidget {
  const AnakPage({super.key});

  @override
  State<AnakPage> createState() => _AnakPageState();
}

class _AnakPageState extends State<AnakPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopNavbar(),
        bottomNavigationBar: const BottomNav(
          index: 2,
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.child_care, color: Colors.black, size: 80),
                const Text(
                  "Tentang Anak",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    marginHorizontal: 40,
                    marginVertical: 10,
                    width: double.infinity,
                    text: const Text(
                      "Rekomendasi Kebutuhan Anak",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    paddingVertical: 8,
                    paddingHorizontal: 0,
                    onPressed: () => {}),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Text(
                      "Temukan rekomendasi produk untuk kebutuhan si buah hati dari dokter terpercaya.",
                      textAlign: TextAlign.center),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    marginHorizontal: 40,
                    marginVertical: 10,
                    width: double.infinity,
                    text: const Text(
                      "Catatan Perkembangan Anak",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    paddingVertical: 8,
                    paddingHorizontal: 0,
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReportPage()))
                        }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Text(
                      "Tambahkan catatan dan pantau tumbuh kembang si buah hati.",
                      textAlign: TextAlign.center),
                ),
                const SizedBox(
                  height: 50,
                ),                
              ],
            )));
  }
}
