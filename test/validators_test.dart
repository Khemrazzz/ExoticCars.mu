import 'package:flutter_test/flutter_test.dart';
import 'package:exotic_cars_apk/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('validates typical emails', () {
      expect(Validators.email('user@example.com'), isNull);
      expect(Validators.email('user+tag@domain.co.uk'), isNull);
      expect(Validators.email('name.surname@domain.photography'), isNull);
    });

    test('rejects invalid emails', () {
      expect(Validators.email('invalid-email'), isNotNull);
      expect(Validators.email('user@domain'), isNotNull);
    });
  });
}
