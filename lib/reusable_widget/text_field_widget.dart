import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData iconData;
  final String validator;
  const TextFormFieldWidget({super.key, required this.hintText, required this.controller, required this.iconData, required this.validator});

  @override
  Widget build(BuildContext context) {
    return  Card(
      shape:const OutlineInputBorder(),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w500),
        decoration:  InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),
            prefixIcon: Icon(iconData),
            border: InputBorder.none
        ),
        validator: (value) {
          if(value!.isEmpty){
            return validator;
          }
        },
      ),
    );
  }
}
