import 'package:flutter_test/flutter_test.dart';
import 'package:quizwiz/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CongratsDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
