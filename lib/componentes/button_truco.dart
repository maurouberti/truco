import 'package:flutter/material.dart';
import 'package:truco/componentes/button.dart';

class ButtonTruco extends StatelessWidget {
  final int pontos;
  final Function onPressed;
  final bool disabled;

  const ButtonTruco({
    Key key,
    @required this.pontos,
    this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textButton = pontos == 1
        ? 'TRUCAR'
        : pontos == 3
            ? 'CHAMAR SEIS'
            : pontos == 6 ? 'CHAMAR NOVE' : pontos == 9 ? 'CHAMAR DOZE' : '';
    return Button(
      textButton: textButton,
      onPressed: onPressed,
      disabled: disabled,
    );
  }
}
