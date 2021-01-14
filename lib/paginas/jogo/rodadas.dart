import 'package:flutter/material.dart';
import 'package:truco/dados/carta_firebase.dart';
import 'package:truco/dados/rodada_firebase.dart';
import 'package:truco/dados/sala_firebase.dart';

class Rodadas extends StatefulWidget {
  final String uuid;
  final SalaFirebase sala;
  Rodadas({this.uuid, this.sala});

  @override
  _RodadasState createState() => _RodadasState();
}

class _RodadasState extends State<Rodadas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Rodada(
            uuid: widget.uuid,
            sala: widget.sala,
            nrRodada: 1,
          ),
          Rodada(
            uuid: widget.uuid,
            sala: widget.sala,
            nrRodada: 2,
          ),
          Rodada(
            uuid: widget.uuid,
            sala: widget.sala,
            nrRodada: 3,
          ),
        ],
      ),
    );
  }
}

class Rodada extends StatelessWidget {
  final String uuid;
  final SalaFirebase sala;
  final int nrRodada;
  const Rodada({
    this.uuid,
    this.sala,
    this.nrRodada,
  });

  @override
  Widget build(BuildContext context) {
    RodadaFirebase rodada = nrRodada == 1
        ? sala.rodada1
        : nrRodada == 2 ? sala.rodada2 : sala.rodada3;
/*
    // Nesta configuração aparecerá as cartas que EU joguei na parte de BAIXO
    CartaFirebase jogadorMeu =
        sala.jogador1 == uuid ? rodada.cartaJogador1 : rodada.cartaJogador2;
    CartaFirebase jogadorAdversario =
        sala.jogador2 == uuid ? rodada.cartaJogador1 : rodada.cartaJogador2;

    String carta1 = jogadorAdversario.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_' + jogadorAdversario.carta + '.png';
    String carta2 = jogadorMeu.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_' + jogadorMeu.carta + '.png';
*/
    CartaFirebase cartaJogada1 = rodada.jogadorIniciou == 1
        ? rodada.cartaJogador1
        : rodada.cartaJogador2;
    CartaFirebase cartaJogada2 = rodada.jogadorIniciou == 1
        ? rodada.cartaJogador2
        : rodada.cartaJogador1;

    String carta1 = cartaJogada1.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_' + cartaJogada1.carta + '.png';
    String carta2 = cartaJogada2.carta == null
        ? 'assets/c_vazio.png'
        : 'assets/c_' + cartaJogada2.carta + '.png';

    String status = (sala.jogador1 == uuid && rodada.jogadorGanhou == 1) ||
            (sala.jogador2 == uuid && rodada.jogadorGanhou == 2)
        ? 'V'
        : (sala.jogador1 == uuid && rodada.jogadorGanhou == 2) ||
                (sala.jogador2 == uuid && rodada.jogadorGanhou == 1)
            ? 'D'
            : rodada.jogadorGanhou == 0 ? '' : null;

    int posCarta1 = 360 - (cartaJogada1.valorCarta ?? 0);
    int posCarta2 = cartaJogada1.valorCarta ?? 0;

    return Stack(
      overflow: Overflow.visible,
      children: [
        RotationTransition(
          turns: AlwaysStoppedAnimation(posCarta1 / 360),
          child: Image.asset(
            carta1,
            width: 90,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -8,
          right: -16,
          child: Container(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(posCarta2 / 360),
              child: Image.asset(
                carta2,
                width: 90,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Visibility(
          visible: status != null,
          child: StatusRodada(status: status),
        ),
      ],
    );
  }
}

class StatusRodada extends StatelessWidget {
  final String status;
  const StatusRodada({this.status});

  @override
  Widget build(BuildContext context) {
    IconData icon = status == 'V'
        ? Icons.check_circle
        : status == 'D' ? Icons.remove_circle : Icons.adjust;
    Color cor = status == 'V'
        ? Colors.green[900]
        : status == 'D' ? Colors.orange[900] : Colors.grey;
    return Positioned(
      top: -8,
      right: -16,
      child: Icon(icon, color: cor),
    );
  }
}
