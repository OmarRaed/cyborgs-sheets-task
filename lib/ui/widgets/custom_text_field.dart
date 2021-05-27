import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final TextInputType inputType;
  CustomTextField({
    @required this.hintText,
    @required this.textController,
    @required this.inputType,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      keyboardType: inputType,
      inputFormatters: inputType == TextInputType.number
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
      validator: (input) {
        if (input.isEmpty) {
          return 'Please type $hintText';
        }
        return null;
      },
      controller: textController,
      textInputAction: TextInputAction.next,
      decoration: new InputDecoration(
          contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: hintText),
    );
  }
}
