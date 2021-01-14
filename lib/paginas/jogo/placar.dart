import 'package:flutter/material.dart';
import 'package:truco/dados/sala_firebase.dart';

class Placar extends StatefulWidget {
  final String uuid;
  final SalaFirebase sala;
  Placar({this.uuid, this.sala});

  @override
  _PlacarState createState() => _PlacarState();
}

class _PlacarState extends State<Placar> {
  @override
  Widget build(BuildContext context) {
    int ptsMeu = widget.sala.jogador1 == widget.uuid
        ? widget.sala.pontosJogador1
        : widget.sala.pontosJogador2;
    int ptsAdversario = widget.sala.jogador1 != widget.uuid
        ? widget.sala.pontosJogador1
        : widget.sala.pontosJogador2;
    return Container(
      height: 30,
      color: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Você: ' + ptsMeu.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Adversário: ' + ptsAdversario.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
