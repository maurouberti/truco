import 'package:truco/dados/carta_firebase.dart';
import 'package:truco/dados/rodada_firebase.dart';
import 'package:truco/dados/sala_firebase.dart';

class Jogada {
  static RodadaFirebase exec(
    String uuid,
    SalaFirebase sala,
    CartaFirebase cartaJogada,
  ) {
    if (sala.vitoria != null) {
      return null;
    }
    if (cartaJogada.valorCarta == null) {
      return null;
    }
    if (uuid == sala.jogador1 && sala.vez != 1) {
      return null;
    }
    if (uuid == sala.jogador2 && sala.vez != 2) {
      return null;
    }
    if (sala.jogador1 == null || sala.jogador2 == null) {
      return null;
    }
    if (uuid != sala.jogador1 && uuid != sala.jogador2) {
      return null;
    }
    if (sala.trucar == 1 || sala.trucar == 2) {
      return null;
    }

    RodadaFirebase rodada;
    if (uuid == sala.jogador1) {
      if (sala.rodada1.cartaJogador1.carta == null) {
        rodada = sala.rodada1;
      } else if (sala.rodada2.cartaJogador1.carta == null) {
        rodada = sala.rodada2;
      } else if (sala.rodada3.cartaJogador1.carta == null) {
        rodada = sala.rodada3;
      }
      rodada.cartaJogador1 = CartaFirebase.fromJson(cartaJogada.toJson());
      rodada.jogadorIniciou =
          rodada.jogadorIniciou == null ? 1 : rodada.jogadorIniciou;
    } else {
      if (sala.rodada1.cartaJogador2.carta == null) {
        rodada = sala.rodada1;
      } else if (sala.rodada2.cartaJogador2.carta == null) {
        rodada = sala.rodada2;
      } else if (sala.rodada3.cartaJogador2.carta == null) {
        rodada = sala.rodada3;
      }
      rodada.cartaJogador2 = CartaFirebase.fromJson(cartaJogada.toJson());
      rodada.jogadorIniciou =
          rodada.jogadorIniciou == null ? 2 : rodada.jogadorIniciou;
    }

    cartaJogada.carta = null;
    cartaJogada.valorCarta = null;
    cartaJogada.valorNaipe = null;

    return rodada;
  }
}
