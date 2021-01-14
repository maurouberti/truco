import 'package:flutter/material.dart';
import 'package:truco/dados/sala_firebase.dart';

class Vez extends StatefulWidget {
  final String uuid;
  final SalaFirebase sala;
  Vez({this.uuid, this.sala});

  @override
  _VezState createState() => _VezState();
}

class _VezState extends State<Vez> {
  @override
  Widget build(BuildContext context) {
    bool trucar =
        ((widget.uuid == widget.sala.jogador1 && widget.sala.trucar == 1) ||
            (widget.uuid == widget.sala.jogador2 && widget.sala.trucar == 2));
    bool trucarAguardando =
        ((widget.uuid == widget.sala.jogador1 && widget.sala.trucar == 2) ||
            (widget.uuid == widget.sala.jogador2 && widget.sala.trucar == 1));

    String msg = '';
    Color fontColor = Colors.white;
    Color color = Colors.amber[900];

    if (widget.sala.vez == null) {
      msg = 'AGUARDANDO INICIAR!';
    } else if (trucar) {
      msg = 'AGUARDANDO RESPOSTA!';
    } else if (trucarAguardando) {
      msg = 'AGUARDANDO SUA RESPOSTA!';
    } else if (widget.sala.vitoria == 0) {
      msg = 'EMPATE!';
    } else if ((widget.uuid == widget.sala.jogador1 &&
            widget.sala.vitoria == 1) ||
        (widget.uuid == widget.sala.jogador2 && widget.sala.vitoria == 2)) {
      msg = 'PARABÉNS, VOCÊ GANHOU! 😁😁😁';
    } else if ((widget.uuid != widget.sala.jogador1 &&
            widget.sala.vitoria == 1) ||
        (widget.uuid != widget.sala.jogador2 && widget.sala.vitoria == 2)) {
      msg = 'VOCÊ PERDEU! 😞😞😞';
    } else if (widget.sala.jogador1 == null || widget.sala.jogador2 == null) {
      msg = 'AGUARDANDO OUTRO JOGADOR ENTRAR';
    } else if ((widget.uuid == widget.sala.jogador1 && widget.sala.vez == 1) ||
        (widget.uuid == widget.sala.jogador2 && widget.sala.vez == 2)) {
      msg = 'SUA VEZ';
      fontColor = Colors.white;
      color = Colors.green[900];
    } else {
      msg = 'AGUARDANDO SUA VEZ';
      fontColor = Colors.white;
      color = Colors.red[900];
    }
    return Container(
      color: color,
      height: 30,
      child: Center(
        child: Text(
          msg,
          style: TextStyle(
            color: fontColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
