import 'package:flutter/material.dart';
import 'package:kembangin_mobile/main.dart';
import 'package:kembangin_mobile/pages/auth/login.dart';
import 'package:kembangin_mobile/pages/auth/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:app_popup_menu/app_popup_menu.dart';

class TopNavbar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return AppBar(
      leading: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
            color: Colors.red,
            icon: const Icon(Icons.home),
            iconSize: 35,
          ),
        ],
      ),
      actions: <Widget>[
        AppPopupMenu(
            color: Colors.pink.shade50,
            icon: IconButton(
              iconSize: 35,
              color: Colors.red,
              icon: const Icon(
                Icons.person_2,
              ),
              onPressed: () {
                // nanti update ya kade
                // do something
              },
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            offset: const Offset(0, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            menuItems: !request.loggedIn
                ? [
                    PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.red),
                          )),
                    ),
                    PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.red),
                          )),
                    )
                  ]
                : [
                    PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()),
                            );
                          },
                          child: const Text(
                            "Profile",
                            style: TextStyle(color: Colors.red),
                          )),
                    ),
                    PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                            Navigator.pop(
                              context,
                            );
                            request.logout(
                                "https://kembangin.up.railway.app/authentication/logout");
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.red),
                          )),
                    )
                  ]),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
