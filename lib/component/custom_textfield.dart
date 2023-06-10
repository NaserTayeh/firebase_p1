// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatelessWidget {
  final Function validation;
  // final Function saveFunction;
  final String label;
  TextEditingController controller = TextEditingController();
  TextInputType? textInputType;
  bool isPassword;

  CustomTextField({
    super.key,
    required this.validation,
    required this.label,
    // required this.saveFunction,
    required this.controller,
    this.textInputType,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      keyboardType: this.textInputType,
      controller: this.controller,
      // onSaved: ((newValue) => saveFunction(newValue)),
      validator: (v) => validation(v),
      decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
