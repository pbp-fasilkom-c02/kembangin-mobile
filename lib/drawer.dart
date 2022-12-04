import 'package:flutter/material.dart';
import 'package:kembangin_mobile/main.dart';
import 'package:kembangin_mobile/pages/auth/login.dart';
import 'package:kembangin_mobile/pages/auth/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: const Text('Counter'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
          !request.loggedIn
              ? Wrap(
                  children: [
                    ListTile(
                      title: const Text('Login'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Register'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                    )
                  ],
                )
              : ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    request.logout(
                        "https://kembangin.up.railway.app/authentication/logout");
                  },
                ),
        ],
      ),
    );
  }
}
