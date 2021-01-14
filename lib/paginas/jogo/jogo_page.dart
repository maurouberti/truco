import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:truco/dados/carta_firebase.dart';
import 'package:truco/dados/rodada_firebase.dart';
import 'package:truco/dados/sala_firebase.dart';
import 'package:truco/paginas/jogo/cartas_fechadas.dart';
import 'package:truco/paginas/jogo/cartas_abertas.dart';
import 'package:truco/paginas/jogo/monte.dart';
import 'package:truco/paginas/jogo/rodadas.dart';
import 'package:truco/paginas/jogo/vez.dart';
import 'package:truco/paginas/jogo/mensagem_trucar.dart';
import 'package:truco/paginas/jogo/placar.dart';
import 'package:truco/logica/iniciar_partida.dart';
import 'package:truco/logica/jogada.dart';
import 'package:truco/logica/definir_status_rodada.dart';
import 'package:truco/logica/definir_vez.dart';
import 'package:truco/logica/verificar_vitoria.dart';
import 'package:truco/logica/trucar.dart';

class JogoPage extends StatefulWidget {
  final String salaId;
  const JogoPage({Key key, this.salaId}) : super(key: key);

  @override
  _JogoPageState createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> {
  String uuid = Uuid().v4();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('salas')
        .doc(widget.salaId)
        .get()
        .then((documentSnapshot) {
      SalaFirebase sala = SalaFirebase.fromDocument(documentSnapshot);
      if (sala.jogador1 == null) {
        sala.jogador1 = uuid;
        sala.salvar();
      } else if (sala.jogador2 == null) {
        sala.jogador2 = uuid;
        sala.salvar();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    FirebaseFirestore.instance
        .collection('salas')
        .doc(widget.salaId)
        .get()
        .then((documentSnapshot) {
      SalaFirebase sala = SalaFirebase.fromDocument(documentSnapshot);
      if (sala.jogador1 == uuid) {
        sala.jogador1 = null;
        sala.salvar();
      } else if (sala.jogador2 == uuid) {
        sala.jogador2 = null;
        sala.salvar();
      }
    });
  }

  void _iniciarPartida(SalaFirebase sala) {
    setState(() {
      IniciarPartida.exec(sala);
      // Mão de onze TRUCAR
      if ((sala.pontosJogador1 == 11 || sala.pontosJogador2 == 11) &&
          (sala.pontosJogador1 + sala.pontosJogador2 != 22)) {
        int jogadorTrucar = sala.pontosJogador1 == 11 ? 2 : 1;
        Trucar.exec(jogadorTrucar, sala);
      }
      sala.salvar();
    });
  }

  void _jogarCarta(
    String uuid,
    SalaFirebase sala,
    CartaFirebase carta,
  ) {
    setState(() {
      RodadaFirebase rodada = Jogada.exec(uuid, sala, carta);
      if (rodada != null) {
        DefinirStatusRodada.exec(rodada, sala.cartaVirada);
        DefinirVez.exec(sala, rodada);
        if (rodada.jogadorGanhou != null) {
          VerificarVitoria.exec(sala);
        }
        sala.salvar();
      }
    });
  }

  void _trucar(
    String uuid,
    SalaFirebase sala,
  ) {
    setState(() {
      int jogadorTrucar = sala.jogador1 == uuid ? 1 : 2;
      Trucar.exec(jogadorTrucar, sala);
      sala.salvar();
    });
  }

  void _aceitar(
    String uuid,
    SalaFirebase sala,
  ) {
    setState(() {
      Trucar.aceitar(uuid, sala);
      sala.salvar();
    });
  }

  void _maisTres(
    String uuid,
    SalaFirebase sala,
  ) {
    setState(() {
      int jogadorTrucar = sala.jogador1 == uuid ? 1 : 2;
      Trucar.exec(jogadorTrucar, sala);
      sala.salvar();
    });
  }

  void _desistir(
    String uuid,
    SalaFirebase sala,
  ) {
    setState(() {
      Trucar.desistir(uuid, sala);
      sala.salvar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('salas')
          .doc(widget.salaId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Aguarde...");
        }
        SalaFirebase salaX = SalaFirebase.fromDocument(snapshot.data);

        bool trucar = ((uuid == salaX.jogador1 && salaX.trucar == 2) ||
            (uuid == salaX.jogador2 && salaX.trucar == 1));

        int vitorias = uuid == salaX.jogador1
            ? salaX.vitoriasJogador1
            : salaX.vitoriasJogador2;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(salaX.nomeSala),
                Text(
                  'Vitórias: ' + vitorias.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                color: Colors.green,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Placar(
                        uuid: uuid,
                        sala: salaX,
                      ),
                      Visibility(
                        visible: trucar,
                        child: MensagemTrucar(
                          uuid: uuid,
                          sala: salaX,
                          aceitar: _aceitar,
                          maisTres: _maisTres,
                          desistir: _desistir,
                        ),
                      ),
                      Visibility(
                        visible: !trucar,
                        child: CartasFechadas(uuid: uuid, sala: salaX),
                      ),
                      Monte(
                        uuid: uuid,
                        sala: salaX,
                        trucar: _trucar,
                        iniciarPartida: _iniciarPartida,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Rodadas(uuid: uuid, sala: salaX),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Vez(uuid: uuid, sala: salaX),
                      ),
                      CartasAbertas(
                        uuid: uuid,
                        sala: salaX,
                        jogarCarta: _jogarCarta,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: (uuid == salaX.jogador1 && salaX.vitoria == 1) ||
                    (uuid == salaX.jogador2 && salaX.vitoria == 2),
                child: Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/confete.png',
                    height: (130 + 130 + 30 + (130 / 2)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
