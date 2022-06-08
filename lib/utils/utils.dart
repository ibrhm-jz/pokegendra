import 'dart:math';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

int getRandom(max) {
  Random random = Random();
  var numberRandom = 1 + random.nextInt(max - 1);
  return numberRandom;
}
