import 'package:parking_management_app/core/utils.dart';
import 'package:test/test.dart';

void main() {
  group('random', () {
    test('number should generation between given min & max range', () {
      final number = random(1, 5);
      expect(number, lessThan(5));
      expect(number, greaterThan(1));
    });
  });

  group('randomNumber', () {
    test('should generate random number up to max range', () {
      final number = randomNumber(10);
      expect(number, lessThan(10));
      expect(number, greaterThan(0));
    });
  });
}
