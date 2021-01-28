import 'package:flutter/material.dart';

class DateFormField extends StatefulWidget {
  DateFormField({Key key, this.hint}) : super(key: key);

  final String hint;

  @override
  DateFormFieldState createState() => DateFormFieldState();
}

class DateFormFieldState extends State<DateFormField> {
  TextEditingController _controller;

  DateTime selectedDate = DateTime.now();

  String get value => _controller.text;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _controller.text = "${picked.day}-${picked.month}-${picked.year}";
      });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: _controller,
      cursorColor: Color.fromRGBO(0, 0, 0, 1),
      cursorWidth: 0.5,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.black38),
          filled: true,
          fillColor: Color.fromRGBO(0, 0, 0, 0.03),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 1.0),
          ),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          suffixIcon: Icon(Icons.date_range)),
    );
  }
}
