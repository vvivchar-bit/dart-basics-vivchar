void main() {
  print('=== Dart Variables & Types Demo ===');

  demonstrateNumbers();
  demonstrateStrings();
  demonstrateBooleans();
  demonstrateCollections();
  demonstrateNullSafety();
}

void demonstrateNumbers() {
  int a = 20;
  double b = 4.5;
  num c = 10;

  print('\n--- Numbers ---');
  print('Addition: ${a + b}');
  print('Subtraction: ${a - b}');
  print('Multiplication: ${a * b}');
  print('Division: ${a / b}');
  print('Remainder: ${a % c}');
  print('Convert to int: ${b.toInt()}');
  print('Convert to double: ${a.toDouble()}');
}

void demonstrateStrings() {
  String name = 'Vadim';
  String surname = 'Vivchar';
  String fullName = '$name $surname';

  print('\n--- Strings ---');
  print(fullName);
  print(fullName.toUpperCase());
  print(fullName.toLowerCase());
  print('Length: ${fullName.length}');
  print('Contains Vadim: ${fullName.contains('Vadim')}');
  print('Name:\t$name');

  print('''
Student: $fullName
Group: ALK43
''');
}

void demonstrateBooleans() {
  bool isStudent = true;
  bool isTeacher = false;

  print('\n--- Booleans ---');
  print(isStudent && isTeacher);
  print(isStudent || isTeacher);
  print(!isStudent);
  print(20 > 10);
  print(isStudent ? 'Student' : 'Teacher');
}

void demonstrateCollections() {
  List<int> numbers = [10, 20, 30];
  Set<int> unique = {1, 2, 2, 3};
  Map<String, int> grades = {
    'Dart': 95,
    'Flutter': 90,
  };

  numbers.add(40);

  print('\n--- Collections ---');
  print(numbers);
  print(unique);
  print(grades);
  print(numbers.length);
  print(grades['Dart']);
}

void demonstrateNullSafety() {
  String? nickname;
  late String group;

  group = 'ALK43';

  print('\n--- Null Safety ---');
  print(nickname ?? 'No nickname');
  print(nickname?.length);
  print(group);

  showStudent(name: 'Vadim');
}

void showStudent({required String name}) {
  print('Student: $name');
}