import 'package:truco/dados/sala_firebase.dart';

class Vitoria {
  static exec(SalaFirebase sala, int vitoriaJogador) {
    sala.vitoria = vitoriaJogador;
    if (vitoriaJogador == 1) {
      sala.pontosJogador1 += sala.pontosRodada;
      if (sala.pontosJogador1 >= 12) {
        sala.vitoriasJogador1 += 1;
      }
    } else if (vitoriaJogador == 2) {
      sala.pontosJogador2 += sala.pontosRodada;
      if (sala.pontosJogador2 >= 12) {
        sala.vitoriasJogador2 += 1;
      }
    }
  }
}
