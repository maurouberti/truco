import 'package:truco/dados/carta_firebase.dart';
import 'package:truco/dados/rodada_firebase.dart';

class DefinirStatusRodada {
  static const EMPATE = 0;
  static const JOGADOR1_VENCEU = 1;
  static const JOGADOR2_VENCEU = 2;

  static exec(RodadaFirebase rodada, CartaFirebase cartaVirada) {
    if (rodada.cartaJogador1.valorCarta == null ||
        rodada.cartaJogador2.valorCarta == null) {
      return null;
    }

    int cartaJogador1 = manilha(rodada.cartaJogador1, cartaVirada);
    int cartaJogador2 = manilha(rodada.cartaJogador2, cartaVirada);

    if (cartaJogador1 > cartaJogador2) {
      rodada.jogadorGanhou = JOGADOR1_VENCEU;
    } else if (cartaJogador1 < cartaJogador2) {
      rodada.jogadorGanhou = JOGADOR2_VENCEU;
    } else {
      rodada.jogadorGanhou = EMPATE;
    }
  }

  static int manilha(CartaFirebase carta, CartaFirebase cartaVirada) {
    int valorManilha = (cartaVirada.valorCarta + 1) % 10;
    if (carta.valorCarta == valorManilha) {
      return 10 + carta.valorNaipe;
    }
    return carta.valorCarta;
  }
}
