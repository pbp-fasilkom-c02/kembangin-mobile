import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/anak/report/report_detail.dart';
import 'package:kembangin_mobile/utils/report_fetch.dart';
import 'package:kembangin_mobile/widgets/bottom_nav.dart';
import 'package:kembangin_mobile/widgets/top_nav.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  void refreshWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    return Scaffold(
      appBar: const TopNavbar(),
      bottomNavigationBar: const BottomNav(
        index: 2,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: fetchReport(request.jsonData['username']),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null || snapshot.data!.length == 0) {
                return Center(
                    child: Column(children: [
                  const SizedBox(height: 100),
                  const Text("Belum ada catatan yang ditambahkan",
                      style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 100),
                  const CircularProgressIndicator(
                    color: Colors.red,
                  ),
                  const SizedBox(height: 100),
                  TextButton(
                    child: const Text("Kembali Ke Menu",
                        style: TextStyle(fontSize: 18, color: Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]));
              } else {
                return Column(children: [
                  const SizedBox(height: 10),
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (data, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReportDetailPage(
                                          report: snapshot.data![index])));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SizedBox(
                                height: 120,
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 15,
                                        left: 15,
                                        right: 15,
                                        top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                snapshot.data![index].name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 20),
                                              )),
                                              IconButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ReportDetailPage(
                                                                    report: snapshot
                                                                            .data![
                                                                        index])));
                                                  },
                                                  icon: const Icon(
                                                      Icons.arrow_forward))
                                            ]),
                                        Row(
                                          children: [
                                            Text(snapshot.data![index].age,
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            const Text("Dibuat pada "),
                                            Text(
                                              "${snapshot.data![index].date.day}/${snapshot.data![index].date.month}/${snapshot.data![index].date.year}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: const Text("Kembali Ke Menu",
                        style: TextStyle(fontSize: 18, color: Colors.red)),
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]);
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade400,
        tooltip: 'Refresh',
        onPressed: () {
          refreshWidget();
        },
        child: const Icon(Icons.sync),
      ),
    );
  }
}
