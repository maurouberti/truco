import 'dart:math';

class Mensagens {
  static const List<String> mensTrucar = [
    'Já que esta tudo perdido mesmo ... %s !!!',
    '%s marreco !!!',
    '%s',
    '%s ladrão !!!',
    '%s ladrão ... aceita !!!',
    'Você se acha o bonzão, então %s !!!',
    '%s então !!!',
    '%s bocó !!!',
  ];

  static String trucar(int valor) {
    String valorStr = valor == 3
        ? 'TRUCO'
        : valor == 6 ? 'SEIS' : valor == 9 ? 'NOVE' : valor == 12 ? 'DOZE' : '';
    Random random = new Random();
    int quantidade = mensTrucar.length;
    int i = random.nextInt(quantidade);
    return mensTrucar[i].replaceAll('%s', valorStr);
  }

  static String maoDeOnze() {
    return 'Mão de onze !!! Se aceitar, esta rodada valerá 3 pontos.';
  }
}
