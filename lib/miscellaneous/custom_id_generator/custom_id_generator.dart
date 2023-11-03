import 'dart:math';

class CustomStringGenerator {
  static String generate(int length) {
    const String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length, (_) =>
          chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }
}