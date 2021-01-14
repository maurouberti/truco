import 'package:flutter/material.dart';
import 'package:truco/dados/cartas_jogador_firebase.dart';
import 'package:truco/dados/sala_firebase.dart';

class CartasFechadas extends StatefulWidget {
  final String uuid;
  final SalaFirebase sala;
  CartasFechadas({this.uuid, this.sala});

  @override
  _CartasFechadasState createState() => _CartasFechadasState();
}

class _CartasFechadasState extends State<CartasFechadas> {
  @override
  Widget build(BuildContext context) {
    CartasJogadorFirebase jogador = widget.uuid == widget.sala.jogador1
        ? widget.sala.cartasJogador2
        : widget.sala.cartasJogador1;
    String carta1 = jogador.carta1.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_verso.png';
    String carta2 = jogador.carta2.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_verso.png';
    String carta3 = jogador.carta3.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_verso.png';
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            carta1,
            width: 90,
            height: 120,
            fit: BoxFit.cover,
          ),
          Image.asset(
            carta2,
            width: 90,
            height: 120,
            fit: BoxFit.fitHeight,
          ),
          Image.asset(
            carta3,
            width: 90,
            height: 120,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
