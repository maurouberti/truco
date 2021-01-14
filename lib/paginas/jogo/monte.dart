import 'package:flutter/material.dart';
import 'package:truco/componentes/button.dart';
import 'package:truco/dados/sala_firebase.dart';
import 'package:truco/componentes/button_truco.dart';
import 'package:truco/logica/trucar.dart';

class Monte extends StatefulWidget {
  final String uuid;
  final SalaFirebase sala;
  final Function trucar;
  final Function iniciarPartida;
  Monte({this.uuid, this.sala, this.trucar, this.iniciarPartida});

  @override
  _MonteState createState() => _MonteState();
}

class _MonteState extends State<Monte> {
  @override
  Widget build(BuildContext context) {
    String carta = widget.sala.cartaVirada.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_' + widget.sala.cartaVirada.carta + '.png';
    bool desabilitarBtTruco = !Trucar.podeChamar(widget.uuid, widget.sala);

    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 150,
            child: Column(
              children: [
                Visibility(
                  visible:
                      widget.sala.vitoria != null || widget.sala.vez == null,
                  child: Button(
                    textButton: 'INICIAR',
                    onPressed: () {
                      widget.iniciarPartida(widget.sala);
                    },
                  ),
                ),
                Visibility(
                  visible: widget.sala.vitoria == null &&
                      widget.sala.vez != null &&
                      widget.sala.trucar != 1 &&
                      widget.sala.trucar != 2 &&
                      widget.sala.pontosRodada < 12 &&
                      widget.sala.pontosJogador1 < 11 &&
                      widget.sala.pontosJogador2 < 11,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 64, 0, 0),
                    child: ButtonTruco(
                      pontos: widget.sala.pontosRodada,
                      disabled: desabilitarBtTruco,
                      onPressed: () {
                        widget.trucar(widget.uuid, widget.sala);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 130,
            width: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 16,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(330 / 360),
                    child: Image.asset(
                      carta,
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  child: Image.asset(
                    'assets/c_monte.png',
                    width: 90,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
