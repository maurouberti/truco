import 'package:truco/dados/carta_firebase.dart';

class RodadaFirebase {
  CartaFirebase cartaJogador1;
  CartaFirebase cartaJogador2;
  int jogadorGanhou;
  int jogadorIniciou;

  RodadaFirebase({
    this.cartaJogador1,
    this.cartaJogador2,
    this.jogadorGanhou,
    this.jogadorIniciou,
  });

  RodadaFirebase.fromJson(Map<String, dynamic> json)
      : cartaJogador1 = json['cartaJogador1'] == null
            ? CartaFirebase()
            : CartaFirebase.fromJson(json['cartaJogador1']),
        cartaJogador2 = json['cartaJogador2'] == null
            ? CartaFirebase()
            : CartaFirebase.fromJson(json['cartaJogador2']),
        jogadorGanhou = json['jogadorGanhou'],
        jogadorIniciou = json['jogadorIniciou'];

  Map<String, dynamic> toJson() => {
        'cartaJogador1':
            (cartaJogador1 == null ? CartaFirebase() : cartaJogador1).toJson(),
        'cartaJogador2':
            (cartaJogador2 == null ? CartaFirebase() : cartaJogador2).toJson(),
        'jogadorGanhou': jogadorGanhou,
        'jogadorIniciou': jogadorIniciou,
      };
}
