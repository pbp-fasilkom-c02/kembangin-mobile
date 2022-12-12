import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/anak/report/add_report.dart';
import 'package:kembangin_mobile/pages/anak/report/reports.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:kembangin_mobile/widgets/toast.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: const TopNavbar(),
      bottomNavigationBar: const BottomNav(
        index: 2,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Catatan",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text(
            "Perkembangan Anak",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          ButtonWidget(
              marginHorizontal: 40,
              marginVertical: 20,
              width: double.infinity,
              text: const Text(
                "Tambah Catatan Baru",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              paddingVertical: 8,
              paddingHorizontal: 0,
              onPressed: () => {
                    if (request.loggedIn) ...[
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddReportPage()))
                    ] else ...[
                      toast(context, true, "Kamu belum login!")
                    ]
                  }),
          ButtonWidget(
              marginHorizontal: 40,
              marginVertical: 20,
              width: double.infinity,
              text: const Text(
                "Lihat Semua Catatan",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              paddingVertical: 8,
              paddingHorizontal: 0,
              onPressed: () => {
                    if (request.loggedIn) ...[
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportsPage()))
                    ] else ...[
                      toast(context, true, "Kamu belum login!")
                    ]
                  }),
          const SizedBox(height: 10),
          TextButton(
            child: const Text("Kembali",
                style: TextStyle(fontSize: 18, color: Colors.red)),
            onPressed: () => {
              Navigator.pop(context),
            },
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}
