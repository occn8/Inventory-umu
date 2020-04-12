import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function ontap;
  const MenuItem({Key key, this.icon, this.title, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}