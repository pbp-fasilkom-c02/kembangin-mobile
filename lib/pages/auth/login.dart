import 'package:kembangin_mobile/drawer.dart';
import 'package:flutter/material.dart';
import 'package:kembangin_mobile/widgets/input_field.dart';
import 'package:kembangin_mobile/widgets/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// TODO: LOGIN UI
class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              onPressed: () => {print("hehe")}),
          const SizedBox(
            height: 20,
          ),
          Text("Tidak mempunyai akun?",
              style: TextStyle(color: Colors.grey.shade700)),
          TextButton(
              onPressed: () => print("hehe"),
              child: Text(
                "SIGN UP",
                style: TextStyle(color: Colors.red.shade500, fontSize: 16),
              )),
        ]),
      ),
      drawer: const MyDrawer(),
    );
  }
}
