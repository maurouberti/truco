import 'package:flutter/material.dart';
import 'package:truco/componentes/button.dart';
import 'package:truco/componentes/button_truco.dart';
import 'package:truco/dados/sala_firebase.dart';
import 'package:truco/logica/mensagens.dart';

class MensagemTrucar extends StatefulWidget {
  final String uuid;
  final SalaFirebase sala;
  final Function aceitar;
  final Function maisTres;
  final Function desistir;
  MensagemTrucar(
      {this.uuid, this.sala, this.aceitar, this.maisTres, this.desistir});

  @override
  _MensagemTrucarState createState() => _MensagemTrucarState();
}

class _MensagemTrucarState extends State<MensagemTrucar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Colors.black45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.sala.pontosJogador1 == 11 || widget.sala.pontosJogador2 == 11
                ? Mensagens.maoDeOnze()
                : Mensagens.trucar(widget.sala.pontosRodada),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                textButton: 'ACEITAR',
                onPressed: () {
                  widget.aceitar(widget.uuid, widget.sala);
                },
              ),
              Visibility(
                visible: widget.sala.pontosJogador1 != 11 &&
                    widget.sala.pontosJogador2 != 11 &&
                    widget.sala.pontosRodada < 12,
                child: ButtonTruco(
                  pontos: widget.sala.pontosRodada,
                  onPressed: () {
                    widget.maisTres(widget.uuid, widget.sala);
                  },
                ),
              ),
              Button(
                textButton: 'DESISTIR',
                onPressed: () {
                  widget.desistir(widget.uuid, widget.sala);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
