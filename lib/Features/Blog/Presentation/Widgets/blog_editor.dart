import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  const BlogEditor({
    super.key,
    required this.controller,
    required this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hinttext),
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hinttext is missing";
        }
        return null;
      },
    );
  }
}
