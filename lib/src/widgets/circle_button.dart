
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key key, @required this.onPressed, @required this.iconPath}) : super(key: key);
  
  final VoidCallback onPressed;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 3.0,
      fillColor: Colors.white,
      child: Container(
        width: 55,
        height: 55,
        padding: EdgeInsets.all(13),
        child: SvgPicture.asset(
          iconPath,
          color: Colors.black87,
        )
      ),
      shape: CircleBorder(
        side: BorderSide(color: Colors.black87, width: 2.0)
      ),
    );
  }
}