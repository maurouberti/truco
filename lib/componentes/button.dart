import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String textButton;
  final Function onPressed;
  final bool disabled;

  const Button({
    Key key,
    this.textButton,
    this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(textButton),
      onPressed: disabled ? null : onPressed,
      color: Colors.green[800],
      disabledColor: Colors.grey,
      textColor: Colors.white,
    );
/*
    return OutlineButton(
      child: Text(textButton),
      onPressed: disabled ? null : onPressed,
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).buttonColor,
    );
*/
  }
}
