// customisation/text_field.dart

import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String hintText;
  final TextStyle hintSyle;
  final Icon icon;
  final TextDirection textDirection;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const Textfield(
      {super.key,
      required this.hintSyle,
      required this.hintText,
      required this.icon,
      required this.controller,
      required this.onChanged,
      required this.textDirection,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        textDirection: textDirection,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 153, 153, 153),
          filled: true,
          hintText: hintText,
          hintStyle: hintSyle,
          suffix: icon,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 14,
            right: 5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: Color(0xffDEDEDF),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffEBEBEC),
            ),
          ),
          // focusedBorder: OutlineInputBorder(borderSide: )
        ),
      ),
    );
  }
}
