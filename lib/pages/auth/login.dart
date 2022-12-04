import 'package:kembangin_mobile/drawer.dart';
import 'package:flutter/material.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/main.dart';
import 'package:kembangin_mobile/pages/auth/register.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String username = "";
  String password1 = "";
  bool isPasswordVisible = false;

  void clear() {
    // Clean up the controller when the widget is disposed.
    usernameController.clear();
    passwordController.clear();

    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              TextButton(
                  onPressed: () => Navigator.pop(
                        context,
                      ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.chevron_left_outlined,
                        color: Colors.red,
                      ),
                      Text(
                        "Kembali",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  )),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(children: [
              const Text(
                "Kembangin",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const Text(
                "❤️",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 40,
              ),
              InputField(
                prefixIcon: Icon(
                  Icons.person_outline,
                  size: 30,
                  color: Colors.red.shade200,
                ),
                hintText: "Username",
                controller: usernameController,
                isPassword: false,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                prefixIcon: Icon(Icons.lock_outline_rounded,
                    size: 30, color: Colors.red.shade200),
                hintText: "Password",
                controller: passwordController,
                isPassword: true,
              ),
              ButtonWidget(
                  marginHorizontal: 40,
                  marginVertical: 25,
                  width: double.infinity,
                  text: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  paddingVertical: 8,
                  paddingHorizontal: 0,
                  onPressed: () async {
                    username = usernameController.text;
                    password1 = passwordController.text;
                    final response = await request.login(
                        "https://kembangin.up.railway.app/authentication/login",
                        {
                          'username': username,
                          'password': password1
                        }).then((response) => {
                          if (response['status'])
                            {
                              request.jsonData = response['user_data'],
                              Navigator.pop(
                                context,
                              ),
                            }
                          else
                            {toast(context, true, response['message'])}
                        });
                  }),
              const SizedBox(
                height: 20,
              ),
              Text("Tidak mempunyai akun?",
                  style: TextStyle(color: Colors.grey.shade700)),
              TextButton(
                  onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      ),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.red.shade500, fontSize: 16),
                  )),
            ]),
          ),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
