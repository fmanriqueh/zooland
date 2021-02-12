import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton({Key key, this.hint, this.selected}) : super(key: key);

  final String hint;
  final String selected;

  @override
  CustomDropdownButtonState createState() => CustomDropdownButtonState();
}

class CustomDropdownButtonState extends State<CustomDropdownButton> {

  String get value => selectedSex;
  
  String selectedSex;
  
  List<String> _sexs = ['Macho', 'Hembra']; 
  

  @override
  void initState() {    
    super.initState();
    selectedSex = widget.selected;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedSex,
      onChanged: (newValue) {
        setState(() {
          selectedSex = newValue;
        });
      },
      items: _sexs.map((sex) {
        return DropdownMenuItem(
          child: Text(sex),
          value: sex,
        );
      }).toList(),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 20)
      ),
    );
  }
}