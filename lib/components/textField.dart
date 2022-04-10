import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final hintText;
  final TextEditingController controller;
  const CustomTextField({ 
    Key? key ,
    this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.cyan.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: TextFormField(
            style: TextStyle(color:Colors.black),
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              fontSize: 16
            ),),
          ),
      ),
    );
  }
}