import 'dart:math';
import 'package:truco/dados/sala_firebase.dart';
import 'package:truco/dados/carta_firebase.dart';
import 'package:truco/dados/baralho.dart';

class IniciarPartida {
  static exec(SalaFirebase sala) {
    List<CartaFirebase> cartas = Baralho.cartas;

    int max = cartas.length;
    List<int> sorteadas = sortear(max, 7);

    sala.cartasJogador1.carta1 =
        CartaFirebase.fromJson(cartas[sorteadas[0]].toJson());
    sala.cartasJogador1.carta2 =
        CartaFirebase.fromJson(cartas[sorteadas[1]].toJson());
    sala.cartasJogador1.carta3 =
        CartaFirebase.fromJson(cartas[sorteadas[2]].toJson());
    sala.cartasJogador2.carta1 =
        CartaFirebase.fromJson(cartas[sorteadas[3]].toJson());
    sala.cartasJogador2.carta2 =
        CartaFirebase.fromJson(cartas[sorteadas[4]].toJson());
    sala.cartasJogador2.carta3 =
        CartaFirebase.fromJson(cartas[sorteadas[5]].toJson());
    sala.cartaVirada = CartaFirebase.fromJson(cartas[sorteadas[6]].toJson());
    sala.rodada1.cartaJogador1 = CartaFirebase();
    sala.rodada1.cartaJogador2 = CartaFirebase();
    sala.rodada1.jogadorGanhou = null;
    sala.rodada1.jogadorIniciou = null;
    sala.rodada2.cartaJogador1 = CartaFirebase();
    sala.rodada2.cartaJogador2 = CartaFirebase();
    sala.rodada2.jogadorGanhou = null;
    sala.rodada2.jogadorIniciou = null;
    sala.rodada3.cartaJogador1 = CartaFirebase();
    sala.rodada3.cartaJogador2 = CartaFirebase();
    sala.rodada3.jogadorGanhou = null;
    sala.rodada3.jogadorIniciou = null;
    sala.iniciarPartida = sala.iniciarPartida == 1 ? 2 : 1;
    sala.vez = sala.iniciarPartida;
    sala.trucar = null;
    sala.trucarUltimo = null;
    sala.vitoria = null;
    sala.pontosRodada = 1;

    if (sala.pontosJogador1 >= 12 || sala.pontosJogador2 >= 12) {
      sala.pontosJogador1 = 0;
      sala.pontosJogador2 = 0;
    }
  }

  static List<int> sortear(int max, int len) {
    if (len > max) return [];
    Random random = new Random();
    List<int> sorteadas = [];
    while (sorteadas.length < len) {
      int index = random.nextInt(max);
      if (!sorteadas.contains(index)) {
        sorteadas.add(index);
      }
    }
    return sorteadas;
  }
}
