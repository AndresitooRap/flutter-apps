import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox(this._controller, this._label, {super.key});
  final TextEditingController _controller;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        
        style: const TextStyle(
          color: Colors.white,
        ),
        controller: _controller,
        
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[900],
          labelText: _label,
          hintStyle: const TextStyle(color: Colors.white),
          labelStyle: const TextStyle(color: Colors.white),
          suffix: GestureDetector(
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onTap: () {
              _controller.clear();
            },
          ),
        ),
      ),
    );
  }
}
