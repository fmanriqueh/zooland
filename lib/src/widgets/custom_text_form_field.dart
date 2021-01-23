import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({Key key, this.hint, this.isPassword = false, this.validator}) : super(key: key);

  final String hint;
  final bool isPassword;
  final Function(String) validator;

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {

  TextEditingController _controller;
  bool _obscuredText = true;

  String get value => _controller.text;

  @override
  void initState() {    
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: _controller,
      cursorColor: Color.fromRGBO(0, 0, 0, 1),
      cursorWidth: 0.5,
      keyboardType: widget.isPassword ? TextInputType.visiblePassword : null,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.black38),
        filled: true,
        fillColor: Color.fromRGBO(0, 0, 0, 0.03),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black26
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black26
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black26,
            width: 1.0
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26)
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        suffixIcon: widget.isPassword ? IconButton(
          icon: Icon(_obscuredText ? Icons.visibility_off : Icons.visibility),
          color: _obscuredText ? Colors.grey : Colors.blueAccent,
          onPressed: () {
            setState((){
              _obscuredText = _obscuredText ? false : true;
            });
          }
        ): null,
      ),
      obscureText: widget.isPassword ? _obscuredText : false,
      validator: widget.validator
    );
  }
}