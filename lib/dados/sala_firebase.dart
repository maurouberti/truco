import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:truco/dados/cartas_jogador_firebase.dart';
import 'package:truco/dados/rodada_firebase.dart';
import 'package:truco/dados/carta_firebase.dart';

class SalaFirebase {
  DocumentReference reference;
  String nomeSala;
  String jogador1;
  String jogador2;
  int vitoria;
  int iniciarPartida;
  int vez;
  int trucar;
  int trucarUltimo;
  int pontosRodada;
  int pontosJogador1;
  int pontosJogador2;
  int vitoriasJogador1;
  int vitoriasJogador2;
  CartasJogadorFirebase cartasJogador1;
  CartasJogadorFirebase cartasJogador2;
  CartaFirebase cartaVirada;
  RodadaFirebase rodada1;
  RodadaFirebase rodada2;
  RodadaFirebase rodada3;

  SalaFirebase({
    this.reference,
    this.jogador1,
    this.jogador2,
    this.vitoria,
    this.iniciarPartida,
    this.vez,
    this.trucar,
    this.trucarUltimo,
    this.nomeSala,
    this.pontosRodada = 1,
    this.pontosJogador1 = 0,
    this.pontosJogador2 = 0,
    this.vitoriasJogador1 = 0,
    this.vitoriasJogador2 = 0,
    this.cartasJogador1,
    this.cartasJogador2,
    this.cartaVirada,
    this.rodada1,
    this.rodada2,
    this.rodada3,
  });

  factory SalaFirebase.fromDocument(DocumentSnapshot doc) {
    return SalaFirebase(
      reference: doc.reference,
      jogador1: doc.data()['jogador1'],
      jogador2: doc.data()['jogador2'],
      vitoria: doc.data()['vitoria'],
      iniciarPartida: doc.data()['iniciarPartida'],
      vez: doc.data()['vez'],
      trucar: doc.data()['trucar'],
      trucarUltimo: doc.data()['trucarUltimo'],
      nomeSala: doc.data()['nomeSala'],
      pontosRodada: doc.data()['pontosRodada'],
      pontosJogador1: doc.data()['pontosJogador1'],
      pontosJogador2: doc.data()['pontosJogador2'],
      vitoriasJogador1: doc.data()['vitoriasJogador1'],
      vitoriasJogador2: doc.data()['vitoriasJogador2'],
      cartasJogador1: doc.data()['cartasJogador1'] == null
          ? CartasJogadorFirebase()
          : CartasJogadorFirebase.fromJson(doc.data()['cartasJogador1']),
      cartasJogador2: doc.data()['cartasJogador2'] == null
          ? CartasJogadorFirebase()
          : CartasJogadorFirebase.fromJson(doc.data()['cartasJogador2']),
      cartaVirada: doc.data()['cartaVirada'] == null
          ? CartaFirebase()
          : CartaFirebase.fromJson(doc.data()['cartaVirada']),
      rodada1: doc.data()['rodada1'] == null
          ? RodadaFirebase()
          : RodadaFirebase.fromJson(doc.data()['rodada1']),
      rodada2: doc.data()['rodada2'] == null
          ? RodadaFirebase()
          : RodadaFirebase.fromJson(doc.data()['rodada2']),
      rodada3: doc.data()['rodada3'] == null
          ? RodadaFirebase()
          : RodadaFirebase.fromJson(doc.data()['rodada3']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jogador1': jogador1,
        'jogador2': jogador2,
        'vitoria': vitoria,
        'iniciarPartida': iniciarPartida,
        'vez': vez,
        'trucar': trucar,
        'trucarUltimo': trucarUltimo,
        'nomeSala': nomeSala,
        'pontosRodada': pontosRodada,
        'pontosJogador1': pontosJogador1,
        'pontosJogador2': pontosJogador2,
        'vitoriasJogador1': vitoriasJogador1,
        'vitoriasJogador2': vitoriasJogador2,
        'cartasJogador1':
            (cartasJogador1 == null ? CartasJogadorFirebase() : cartasJogador1)
                .toJson(),
        'cartasJogador2':
            (cartasJogador2 == null ? CartasJogadorFirebase() : cartasJogador2)
                .toJson(),
        'cartaVirada':
            (cartaVirada == null ? CartaFirebase() : cartaVirada).toJson(),
        'rodada1': (rodada1 == null ? RodadaFirebase() : rodada1).toJson(),
        'rodada2': (rodada2 == null ? RodadaFirebase() : rodada2).toJson(),
        'rodada3': (rodada3 == null ? RodadaFirebase() : rodada3).toJson(),
      };

  criar() async {
    var data = this.toJson();
    String chave = DateFormat("yyyy-MM-dd-HH:mm:ss").format(DateTime.now());
    await FirebaseFirestore.instance.collection('salas').doc(chave).set(data);
  }

  excluir() async {
    await reference.delete();
  }

  salvar() async {
    var data = this.toJson();
    await reference.update(data);
  }
}
