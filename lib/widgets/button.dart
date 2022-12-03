import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final double width;
  final Widget text;
  final double paddingVertical;
  final double paddingHorizontal;
  final double marginVertical;
  final double marginHorizontal;
  final Function() onPressed;

  const ButtonWidget(
      {super.key,
      required this.width,
      required this.text,
      required this.paddingVertical,
      required this.paddingHorizontal,
      required this.marginVertical,
      required this.marginHorizontal,
      required this.onPressed});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.symmetric(
          horizontal: widget.marginHorizontal, vertical: widget.marginVertical),
      width: widget.width,
      decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(95, 216, 91, 91),
                blurRadius: 10,
                offset: Offset(0, 5),
                spreadRadius: 0)
          ]),
      child: TextButton(
          onPressed: () => widget.onPressed,
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: widget.paddingVertical,
                  horizontal: widget.paddingHorizontal),
              child: widget.text)),
    ));
  }
}
