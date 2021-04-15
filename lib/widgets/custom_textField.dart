import 'package:flutter/material.dart';


class MultiLineTextInput extends StatelessWidget {
  String m_hintText;
  String m_helperText;
  String m_labelText;
  TextEditingController controller;
  TextInputType keyboardType;

  MultiLineTextInput(
      {this.m_hintText="", this.m_helperText="", this.m_labelText="", this.controller, this.keyboardType=TextInputType.text}

  );



  @override
  Widget build(BuildContext context) {
    return  new Theme(
      data: new ThemeData(
        primaryColor: ThemeData().primaryColor,
        primaryColorDark: Colors.grey,
      ),
      child: new TextField(

        controller: controller,
        minLines: 1,//Normal textInputField will be displayed
        maxLines: 5,// when user presses enter it will adapt to it
        keyboardType: keyboardType,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)),
            hintText: m_hintText,
            helperText: m_helperText,
            labelText: m_labelText,
            prefixIcon: const Icon(
              Icons.pending_actions,
            ),
            prefixText: ' ',
            suffixIcon:Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.clear)),
            ),
            suffixStyle: const TextStyle(color: Colors.red)),
      ),
    );
  }
}