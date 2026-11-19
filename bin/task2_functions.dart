import '../lib/utils/calculator.dart';

void main() {
  print('=== Dart Functions Demo ===');

  testBasicFunctions();
  testAdvancedFunctions();
  testFunctionalProgramming();
  analyzeText('Dart is a modern programming language');
}

int calculateSum(int a, int b) => a + b;

double calculateAverage(List<double> numbers) {
  return Calculator.average(numbers);
}

String formatName(
    String firstName,
    String lastName, {
      String? middleName,
      bool uppercase = false,
    }) {
  String name = [firstName, middleName, lastName]
      .whereType<String>()
      .join(' ');

  return uppercase ? name.toUpperCase() : name;
}

int fibonacci(int n) {
  if (n < 0) throw ArgumentError('Negative number');
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

int factorial(int n) {
  if (n < 0) throw ArgumentError('Negative number');
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

void testBasicFunctions() {
  print('\n--- Calculator ---');
  print('Addition: ${Calculator.add(20, 5)}');
  print('Subtraction: ${Calculator.subtract(20, 5)}');
  print('Multiplication: ${Calculator.multiply(20, 5)}');
  print('Division: ${Calculator.divide(20, 5)}');
  print('Sum: ${calculateSum(10, 15)}');
  print('Average: ${calculateAverage([10, 20, 30])}');
}

void testAdvancedFunctions() {
  print('\n--- Advanced Functions ---');
  print(formatName('Vadim', 'Vivchar'));
  print(formatName('Vadim', 'Vivchar', uppercase: true));
  print('Fibonacci: ${fibonacci(10)}');
  print('Factorial: ${factorial(5)}');
}

void testFunctionalProgramming() {
  print('\n--- Functional Programming ---');

  final numbers = [1, 2, 3, 4, 5, 6];

  print('Map: ${numbers.map((n) => n * 2).toList()}');
  print('Where: ${numbers.where((n) => n.isEven).toList()}');
  print('Fold: ${numbers.fold(0, (a, b) => a + b)}');

  int multiplier = 3;
  final multiply = (int n) => n * multiplier;

  print('Closure: ${multiply(5)}');
}

void analyzeText(String text) {
  final words = text.trim().isEmpty
      ? 0
      : text.trim().split(RegExp(r'\s+')).length;

  print('\n--- Text Analysis ---');
  print('Text: $text');
  print('Words: $words');
  print('Characters: ${text.length}');
  print('Characters without spaces: ${text.replaceAll(RegExp(r'\s'), '').length}');
}
