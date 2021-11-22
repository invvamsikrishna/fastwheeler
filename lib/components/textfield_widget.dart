import 'package:flutter/material.dart';

import '../size_config.dart';

class LocationTextField extends StatelessWidget {
  final String lable;
  final TextEditingController controller;
  final Function() function;
  const LocationTextField({
    Key? key,
    required this.lable,
    required this.controller,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      child: TextField(
        onTap: function,
        controller: controller,
        readOnly: true,
        showCursor: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.add_location_alt_outlined,
            color: lable == "Destination" ? Colors.red : Colors.green,
          ),
          labelText: lable,
          hintText: "Choose $lable",
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.lightGreen,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.lightGreen,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal:8),
        ),
      ),
    );
  }
}
