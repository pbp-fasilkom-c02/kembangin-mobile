import 'package:flutter/material.dart';
import 'package:kembangin_mobile/main.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kembangin_mobile/pages/anak/anak.dart';

import 'models/rekomendasi_model.dart';

class BottomNav extends StatefulWidget {
  final List<Rekomendasi> lst;
  final Function(Rekomendasi) addData;

  const BottomNav({super.key, required this.lst, required this.addData});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.pink.shade50,
      child: GNav(
        backgroundColor: Colors.pink.shade50,
        tabBackgroundColor: Colors.red.shade100,
        padding: const EdgeInsets.all(16),
        tabs: [
          GButton(
            icon: Icons.newspaper_sharp,
            iconSize: 30,
            iconColor: Colors.red,
            iconActiveColor: Colors.red.shade900,
            text: 'Artikel',
            textColor: Colors.red.shade900,
            gap: 8,
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()))
            },
          ),
          GButton(
            icon: Icons.chat_bubble_sharp,
            iconSize: 30,
            iconColor: Colors.red,
            iconActiveColor: Colors.red.shade900,
            text: 'Forum',
            textColor: Colors.red.shade900,
            gap: 8,
            onPressed: () => {},
          ),
          GButton(
            icon: Icons.child_care_sharp,
            iconSize: 30,
            iconColor: Colors.red,
            iconActiveColor: Colors.red.shade900,
            text: 'Anak',
            textColor: Colors.red.shade900,
            gap: 8,
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyAnakPage(
                    ),
                  ))
            },
          ),
          GButton(
            icon: Icons.calculate_rounded,
            iconSize: 30,
            iconColor: Colors.red,
            iconActiveColor: Colors.red.shade900,
            text: 'BMI',
            textColor: Colors.red.shade900,
            gap: 8,
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}
