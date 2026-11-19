import 'dart:io';
import 'dart:convert';

import 'package:dart_basics_vivchar/models/student.dart';
import 'package:dart_basics_vivchar/models/course.dart';
import 'package:dart_basics_vivchar/models/university.dart';
import 'package:dart_basics_vivchar/utils/data_processor.dart';

void main() {
  print('=== Dart Collections & Data Processing Demo ===');

  demonstrateLists();
  demonstrateSets();
  demonstrateMaps();
  demonstrateAdvancedOperations();
}

void demonstrateLists() {
  final numbers = [8, 3, 6, 1, 9, 2, 4];

  print('\n--- Lists ---');
  print('Original: $numbers');
  print('Even: ${DataProcessor.filterEvenNumbers(numbers)}');
  print('Map: ${numbers.map((n) => n * 2).toList()}');
  print('Where: ${numbers.where((n) => n > 4).toList()}');
  print('Fold: ${numbers.fold(0, (a, b) => a + b)}');
  print('Reduce: ${numbers.reduce((a, b) => a + b)}');

  numbers.sort();
  print('Sorted: $numbers');
}

void demonstrateSets() {
  final a = {'Dart', 'Flutter', 'Python'};
  final b = {'Dart', 'Java', 'C#'};

  print('\n--- Sets ---');
  print('Union: ${a.union(b)}');
  print('Intersection: ${a.intersection(b)}');
  print('Difference: ${a.difference(b)}');
}

void demonstrateMaps() {
  print('\n--- Maps ---');
  print(DataProcessor.countWords('Dart Flutter Dart Java Flutter Dart'));
}

void demonstrateAdvancedOperations() {
  final stopwatch = Stopwatch()..start();
  final lines = File('data/students.csv').readAsLinesSync();
  final students = <String, Student>{};

  for (final line in lines.skip(1)) {
    if (line.trim().isEmpty) continue;

    final row = line.split(',');

    final student = students.putIfAbsent(
      row[0],
      () => Student(
        id: row[0],
        firstName: row[1],
        lastName: row[2],
        birthDate: DateTime.parse(row[3]),
      ),
    );

    student.enrollInCourse(row[4]);
    student.addGrade(row[4], double.parse(row[5]));
  }

  final university = University(
    name: 'ISTU',
    students: students.values.toList(),
    courses: [
      Course(
        id: 'C001',
        name: 'Dart',
        description: 'Dart basics',
        credits: 4,
        instructor: 'Professor',
      ),
      Course(
        id: 'C002',
        name: 'Flutter',
        description: 'Mobile development',
        credits: 5,
        instructor: 'Professor',
      ),
    ],
  );

  print('\n--- Student Ranking ---');

  final ranking = DataProcessor.sortStudentsByGPA(university.students);

  for (final student in ranking) {
    print(student);
  }

  print('\n--- Common Courses ---');
  print(DataProcessor.findCommonCourses(university.students));

  print('\n--- Birth Year Groups ---');
  print(DataProcessor.groupStudentsByYear(university.students));

  print('\n--- Average Grades ---');

  final averages = DataProcessor.calculateAverageGradesByCourse(
    university.students,
  );

  averages.forEach((course, grade) {
    final bar = List.filled((grade / 5).round(), '#').join();
    print('$course: $bar ${grade.toStringAsFixed(2)}');
  });

  final report = DataProcessor.generateReport(university);

  Directory('reports').createSync(recursive: true);

  File('reports/analysis.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({
      'statistics': university.generateStatistics(),
      'ranking': ranking,
      'courses': report,
    }),
  );

  stopwatch.stop();

  print('\nReport saved: reports/analysis.json');
  print('Processing time: ${stopwatch.elapsedMicroseconds} us');
}
