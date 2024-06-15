import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AuthButton extends StatefulWidget {
  String text;
  Color color;
  Color text_color;
  double height,width,radius;
  Function() ontap;
  TextStyle style;
  AuthButton({
    required this.text,
    required this.height,
    required this.radius,
    required this.width,
    required this.color,
    required this.text_color,
    required this.ontap, required this.style,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius)
      ),
      child: MaterialButton(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius)
        ),
        color: widget.color,
        onPressed: widget.ontap,
        child: Text(widget.text,style: widget.style,),
      ),
    );
  }
}
