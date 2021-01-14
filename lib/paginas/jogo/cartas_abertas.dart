import 'package:flutter/material.dart';
import 'package:truco/dados/cartas_jogador_firebase.dart';
import 'package:truco/dados/sala_firebase.dart';

class CartasAbertas extends StatefulWidget {
  final String uuid;
  final SalaFirebase sala;
  final Function jogarCarta;
  CartasAbertas({this.uuid, this.sala, this.jogarCarta});

  @override
  _CartasAbertasState createState() => _CartasAbertasState();
}

class _CartasAbertasState extends State<CartasAbertas> {
  @override
  Widget build(BuildContext context) {
    CartasJogadorFirebase jogador = widget.uuid == widget.sala.jogador1
        ? widget.sala.cartasJogador1
        : widget.sala.cartasJogador2;
    String carta1 = jogador.carta1.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_' + jogador.carta1.carta + '.png';
    String carta2 = jogador.carta2.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_' + jogador.carta2.carta + '.png';
    String carta3 = jogador.carta3.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_' + jogador.carta3.carta + '.png';
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              widget.jogarCarta(widget.uuid, widget.sala, jogador.carta1);
            },
            child: Image.asset(
              carta1,
              width: 90,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          InkWell(
            onTap: () {
              widget.jogarCarta(widget.uuid, widget.sala, jogador.carta2);
            },
            child: Image.asset(
              carta2,
              width: 90,
              height: 120,
              fit: BoxFit.fitHeight,
            ),
          ),
          InkWell(
            onTap: () {
              widget.jogarCarta(widget.uuid, widget.sala, jogador.carta3);
            },
            child: Image.asset(
              carta3,
              width: 90,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
