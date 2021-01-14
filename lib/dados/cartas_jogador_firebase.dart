import 'package:truco/dados/carta_firebase.dart';

class CartasJogadorFirebase {
  CartaFirebase carta1;
  CartaFirebase carta2;
  CartaFirebase carta3;

  CartasJogadorFirebase({
    this.carta1,
    this.carta2,
    this.carta3,
  });

  CartasJogadorFirebase.fromJson(Map<String, dynamic> json)
      : carta1 = json['carta1'] == null
            ? CartaFirebase()
            : CartaFirebase.fromJson(json['carta1']),
        carta2 = json['carta2'] == null
            ? CartaFirebase()
            : CartaFirebase.fromJson(json['carta2']),
        carta3 = json['carta3'] == null
            ? CartaFirebase()
            : CartaFirebase.fromJson(json['carta3']);

  Map<String, dynamic> toJson() => {
        'carta1': (carta1 == null ? CartaFirebase() : carta1).toJson(),
        'carta2': (carta2 == null ? CartaFirebase() : carta2).toJson(),
        'carta3': (carta3 == null ? CartaFirebase() : carta3).toJson(),
      };
}
