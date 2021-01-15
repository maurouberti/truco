import 'package:truco/dados/sala_firebase.dart';
import 'package:truco/logica/vitoria.dart';

class VerificarVitoria {
  static exec(SalaFirebase sala) {
    int vitoriaJogador;

    int primeira = sala.rodada1.jogadorGanhou;
    int segunda = sala.rodada2.jogadorGanhou;
    int terceira = sala.rodada3.jogadorGanhou;
    if (primeira == 0 && segunda == 0 && terceira == 0) {
      // Se todas as três rodadas empatarem, ninguém ganha ponto');
      vitoriaJogador = 0;
    } else if (primeira == 0 &&
        segunda == 0 &&
        (terceira == 1 || terceira == 2)) {
      // Se empatar na primeira e segunda rodada, quem fizer a terceira vence a mão');
      vitoriaJogador = terceira;
    } else if (primeira == 0 && (segunda == 1 || segunda == 2)) {
      // Se empatar na primeira rodada, quem ganhar a segunda vence a mão');
      vitoriaJogador = segunda;
    } else if ((primeira == 1 || primeira == 2) && segunda == 0) {
      // Se empatar na segunda rodada, quem ganhou a primeira vence a mão');
      vitoriaJogador = primeira;
    } else if (terceira == 0) {
      // Se empatar na terceira rodada, quem ganhou a primeira vence a mão');
      vitoriaJogador = primeira;
    } else if ((primeira == 1 || primeira == 2) && primeira == segunda) {
      // Vitória em duas rodadas');
      vitoriaJogador = segunda;
    } else if (primeira != null && segunda != null && terceira != null) {
      // Vitória em três rodadas');
      vitoriaJogador = terceira;
    }

    Vitoria.exec(sala, vitoriaJogador);
  }
}
