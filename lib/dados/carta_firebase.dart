class CartaFirebase {
  String carta;
  int valorCarta;
  int valorNaipe;

  CartaFirebase({this.carta, this.valorCarta, this.valorNaipe});

  CartaFirebase.fromJson(Map<String, dynamic> json)
      : carta = json['carta'],
        valorCarta = json['valorCarta'],
        valorNaipe = json['valorNaipe'];

  Map<String, dynamic> toJson() => {
        'carta': carta,
        'valorCarta': valorCarta,
        'valorNaipe': valorNaipe,
      };
}
