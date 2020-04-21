import 'package:flutter/material.dart';

class ButtonLink extends StatelessWidget {
  final String text;
  final Function ontap;

  const ButtonLink({Key key, this.text, this.ontap, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 100,
      width: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color:  Colors.grey[200],
        child: InkWell(
          onTap: ontap,
          child: Center(
            child: Text(text,style: TextStyle(color: Colors.black),
          ),
          ),
        ),
      ));
  }
}
