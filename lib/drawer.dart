import 'package:flutter/material.dart';
import 'package:kembangin_mobile/main.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: const Text('Main Page'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
          ListTile(
            title: const Text('Artikel'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyArtikelPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
