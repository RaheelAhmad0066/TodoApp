
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  CustomField({
    super.key,
     required this.controller,
    this.title,
    this.keyboardType,
    this.validator,
    this.maxline,
    this.minLine
  });

   TextEditingController controller = TextEditingController();
  final String? title;
  final int?maxline;
  final int?minLine;

  final TextInputType? keyboardType;
  void Function(String)? onChanged;

  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       controller: controller,
      minLines:minLine ,
      maxLines: maxline,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        hintText: title,
        labelText: title,
        hintStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
