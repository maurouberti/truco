import 'package:truco/dados/sala_firebase.dart';
import 'package:truco/logica/vitoria.dart';

class Trucar {
/*
  static exec(String uuid, SalaFirebase sala) {
    sala.trucar = sala.jogador1 == uuid ? 1 : 2;
    sala.trucarUltimo = sala.trucar;
    sala.pontosRodada += sala.pontosRodada == 1 ? 2 : 3;
  }
*/
  static exec(int jogador, SalaFirebase sala) {
    sala.trucar = jogador;
    sala.trucarUltimo = sala.trucar;
    sala.pontosRodada += sala.pontosRodada == 1 ? 2 : 3;
  }

  static aceitar(String uuid, SalaFirebase sala) {
    sala.trucar = null;
  }

  static desistir(String uuid, SalaFirebase sala) {
    sala.trucar = null;
    sala.pontosRodada -= sala.pontosRodada == 3 ? 2 : 3;
    int vitoriaJogador = sala.jogador1 == uuid ? 2 : 1;
    Vitoria.exec(sala, vitoriaJogador);
  }

  static bool podeChamar(String uuid, SalaFirebase sala) {
    bool result = false;
    if ((sala.jogador1 == uuid && sala.vez == 1 && sala.trucarUltimo != 1) ||
        (sala.jogador2 == uuid && sala.vez == 2 && sala.trucarUltimo != 2)) {
      result = true;
    }
    if (sala.vitoria == 1 || sala.vitoria == 2) {
      result = false;
    }

    return result;
  }
}
