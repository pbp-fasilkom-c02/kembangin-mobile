import 'package:flutter/material.dart';
import 'package:kembangin_mobile/models/report_model.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';

class ReportDetailPage extends StatelessWidget {
  const ReportDetailPage({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavbar(),
      bottomNavigationBar: const BottomNav(
        index: 2,
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child:
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Text("${report.name} (${report.age})",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Text(
                      "Dibuat pada ${report.date.day}/${report.date.month}/${report.date.year}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700)),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Tinggi Badan Anak: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(report.height, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Berat Badan Anak: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(report.weight, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Tingkat Makan Anak: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(report.eat, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Tingkat Minum Anak: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(report.drink, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Perkembangan Pada Anak: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(report.progress,
                          style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ],
            )),
            const Spacer(),
            ButtonWidget(
                marginHorizontal: 40,
                marginVertical: 5,
                width: double.infinity,
                text: const Text(
                  "Kembali",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                paddingVertical: 8,
                paddingHorizontal: 0,
                onPressed: () {
                  Navigator.pop(context);
                }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
