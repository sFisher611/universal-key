import 'dart:math';

class FunctionGenerator {
  static generatorCheck(String code, key) {
    var date = DateTime.now().toString();
    String start = date.substring(14, 15);
    String finish = date.substring(15, 16);
    if (start == code.substring(0, 1) &&
        finish == code.substring(3, 4) &&
        _checkCodeBody(code.substring(1, 3), start + finish)) {
      return true;
    } else {
      return false;
    }
  }

  static bool _checkCodeBody(text, key) {
    int numKey = int.parse(key);
    int numCode = int.parse(text);
    if ((numCode % 2 == 0 && numKey % 2 != 0) ||
        (numCode % 2 != 0 && numKey % 2 == 0)) {
      return true;
    } else {
      return false;
    }
  }

  static generatorKey() {
    Random random = Random();
    int key = random.nextInt(100000);
    return "$key";
  }
}
