import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String initValues;
  final Function(String val) onSaved;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String Function(String val) validators;

  CustomTextFormField(
      {this.label,
      this.initValues,
      this.onSaved,
      this.keyboardType,
      this.controller,
      this.validators});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValues,
      validator: validators,
      controller: controller,
      keyboardType: keyboardType,
      onSaved: onSaved,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          hintText: label,
          filled: true,
          fillColor: Colors.grey[350],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          )),
    );
  }
}
