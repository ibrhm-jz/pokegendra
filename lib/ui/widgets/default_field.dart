import 'package:flutter/material.dart';

class DefaultField extends StatefulWidget {
  DefaultField({
    Key? key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
  });
  final TextEditingController controller;
  String? hintText;
  bool? obscureText;

  @override
  _DefaultFieldState createState() => _DefaultFieldState();
}

class _DefaultFieldState extends State<DefaultField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: widget.controller,
      keyboardType: TextInputType.text,
      obscureText: widget.obscureText!,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              width: 1, style: BorderStyle.solid, color: Colors.amber),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        // fillColor: Colors.red,
      ),
    );
  }
}
