import 'package:truco/dados/rodada_firebase.dart';
import 'package:truco/dados/sala_firebase.dart';

class DefinirVez {
  static exec(SalaFirebase sala, RodadaFirebase rodada) {
    if (rodada.jogadorGanhou != null && rodada.jogadorGanhou > 0) {
      sala.vez = rodada.jogadorGanhou;
    } else {
      sala.vez = sala.vez == 1 ? 2 : 1;
    }
  }
}
