import 'package:test/test.dart';
import '../lib/utils/calculator.dart';
import '../lib/utils/data_processor.dart';

void main() {
  group('Calculator tests', () {
    test('Addition', () {
      expect(Calculator.add(10, 5), 15);
    });

    test('Subtraction', () {
      expect(Calculator.subtract(10, 5), 5);
    });

    test('Multiplication', () {
      expect(Calculator.multiply(10, 5), 50);
    });

    test('Division', () {
      expect(Calculator.divide(10, 5), 2);
    });

    test('Division by zero', () {
      expect(
            () => Calculator.divide(10, 0),
        throwsArgumentError,
      );
    });

    test('Average', () {
      expect(Calculator.average([10, 20, 30]), 20);
    });

    test('Empty list', () {
      expect(Calculator.average([]), 0);
    });
  });

  group('DataProcessor tests', () {
    test('Filter even numbers', () {
      expect(
        DataProcessor.filterEvenNumbers([1, 2, 3, 4, 5, 6]),
        [2, 4, 6],
      );
    });

    test('Count words', () {
      expect(
        DataProcessor.countWords('Dart Flutter Dart'),
        {'dart': 2, 'flutter': 1},
      );
    });

    test('Empty text', () {
      expect(DataProcessor.countWords(''), isEmpty);
    });
  });
}