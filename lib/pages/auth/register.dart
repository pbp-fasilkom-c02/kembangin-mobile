import 'package:flutter/material.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kembangin_mobile/pages/auth/login.dart';
import 'package:kembangin_mobile/widgets/toast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  String username = "";
  String email = "";
  String password1 = "";
  String password2 = "";
  String? isDoctor = "";
  bool isPasswordVisible = false;

  void clear() {
    // Clean up the controller when the widget is disposed.
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
    repeatPasswordController.clear();

    // super.dispose();
  }

  void _errorToast(BuildContext context, bool isError) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: const Text("Username atau password kamu Salah!"),
        action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {
              scaffold.hideCurrentSnackBar;
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

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
            margin: const EdgeInsets.only(top: 20),
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
                prefixIcon: Icon(
                  Icons.mail_outline,
                  size: 30,
                  color: Colors.red.shade200,
                ),
                hintText: "Email",
                controller: emailController,
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
              const SizedBox(
                height: 10,
              ),
              InputField(
                prefixIcon: Icon(Icons.lock_outline_rounded,
                    size: 30, color: Colors.red.shade200),
                hintText: "Repeat Password",
                controller: repeatPasswordController,
                isPassword: true,
              ),
              const SizedBox(height: 20),

              const Text("Apakah anda dokter?"),
              // TODO: FIX THIS LATER
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Radio(
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.red),
                  value: "yes",
                  groupValue: isDoctor,
                  onChanged: (String? value) {
                    setState(() {
                      isDoctor = value;
                    });
                  },
                ),
                const Text('Ya'),
                Radio(
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.red),
                  value: "no",
                  groupValue: isDoctor,
                  onChanged: (String? value) {
                    setState(() {
                      isDoctor = value;
                    });
                  },
                ),
                const Text('Tidak')
              ]),
              ButtonWidget(
                  marginHorizontal: 40,
                  marginVertical: 25,
                  width: double.infinity,
                  text: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  paddingVertical: 8,
                  paddingHorizontal: 0,
                  onPressed: () async {
                    username = usernameController.text;
                    password1 = passwordController.text;
                    email = emailController.text;
                    password2 = repeatPasswordController.text;
                    final response = await request.post(
                        "https://kembangin.up.railway.app/authentication/register",
                        {
                          'username': username,
                          'email': email,
                          'password': password1,
                          'repeat_password': password2,
                          'doctor_choice': isDoctor
                        }).then((value) => {
                          if (value['status'])
                            {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              ),
                              toast(context, false, value['message'])
                            }
                          else
                            {toast(context, true, value['message'])}
                        });
                  }),
            ]),
          ),
        ],
      ),
    );
  }
}
