import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final Icon prefixIcon;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const InputField(
      {super.key,
      required this.prefixIcon,
      required this.hintText,
      required this.isPassword,
      required this.controller});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurRadius: 50,
                offset: Offset(0, 5),
                spreadRadius: -36)
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: widget.controller,
          obscureText: widget.isPassword,
          decoration: InputDecoration(
              hintStyle: const TextStyle(color: Color(0xffA6B0BD)),
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: const BoxConstraints(minWidth: 75),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.red)))),
    ));
  }
}
