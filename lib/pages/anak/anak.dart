import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:kembangin_mobile/pages/anak/rekomendasi.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/pages/auth/login.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

import '../../models/rekomendasi_model.dart';
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('Anak'),
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text("Kebutuhan Anak"),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyRekomendasiPage()));
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Perkembangan Anak"),
                  ),
                ),
              ],
            )));
  }
}
