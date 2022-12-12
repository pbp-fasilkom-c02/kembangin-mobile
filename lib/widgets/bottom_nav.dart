import 'package:flutter/material.dart';
import 'package:kembangin_mobile/main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_card.dart';
import 'package:kembangin_mobile/pages/artikel/artikel_page.dart';
import 'package:kembangin_mobile/pages/anak/anak.dart';
import 'package:kembangin_mobile/pages/bmicalculator/bmi_form2.dart';
import 'package:kembangin_mobile/pages/forum/forum_page.dart';

class BottomNav extends StatefulWidget {
  final int index;
  const BottomNav({super.key, required this.index});

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
        selectedIndex: widget.index,
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
              widget.index != 0
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ArtikelPage()))
                  : null
            },
          ),
          GButton(
            icon: Icons.question_answer_outlined,
            iconSize: 30,
            iconColor: Colors.red,
            iconActiveColor: Colors.red.shade900,
            text: 'Forum',
            textColor: Colors.red.shade900,
            gap: 8,
            onPressed: () => {
              widget.index != 1
                  ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForumPage()))
                  : null
            },
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AnakPage()))
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
            onPressed: () => {
              widget.index != 3
                  ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BmiFormPage()))
                  : null
            },
          )
        ],
      ),
    );
  }
}
