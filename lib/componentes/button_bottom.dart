import 'package:flutter/material.dart';

class ButtonBottom extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onClick;
  const ButtonBottom({this.label, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 100.0,
      child: RaisedButton(
        onPressed: this.onClick,
        elevation: 0,
        color: Theme.of(context).bottomAppBarColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Theme.of(context).accentColor,
            ),
            Text(label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  // color: Theme.of(context).accentColor,
                )),
          ],
        ),
      ),
    );
  }
}
