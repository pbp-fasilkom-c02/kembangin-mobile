import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/anak/rekomendasi.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/pages/auth/login.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

import '../../bottom_nav.dart';
import '../../main.dart';
import '../../models/rekomendasi_model.dart';
import '../../top_nav.dart';
import '../../utils/rekomendasi_fetch.dart';

class MyAnakPage extends StatefulWidget {
  const MyAnakPage({super.key});

  @override
  _MyAnakPageState createState() => _MyAnakPageState();
}

class _MyAnakPageState extends State<MyAnakPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.grey;
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: const TopNavbar(),
      bottomNavigationBar: const BottomNav(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const Text('Perkembangan Anak'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()))
              },
            ),
            ListTile(
              title: const Text('Rekomendasi Anak'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyRekomendasiPage()),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
