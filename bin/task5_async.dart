import 'dart:io';
import 'dart:convert';
import '../lib/models/student.dart';

Future<void> main() async {
  print('=== Dart Async Programming Demo ===');

  await demonstrateFutures();
  await demonstrateStreams();
  await demonstrateFileOperations();
}

Future<String> fetchStudentData(String studentId) async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Student data loaded: $studentId';
}

Future<List<Student>> loadStudentsFromFile(String filename) async {
  final content = await File(filename).readAsString();
  final data = jsonDecode(content) as List;

  return data.map((item) => Student.fromJson(item)).toList();
}

Future<void> saveStudentsToFile(
    List<Student> students,
    String filename,
    ) async {
  final data = students.map((s) => s.toJson()).toList();

  await File(filename).writeAsString(
    const JsonEncoder.withIndent('  ').convert(data),
  );
}

Stream<Student> studentStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(const Duration(milliseconds: 300));

    yield Student(
      id: 'S00$i',
      firstName: 'Student',
      lastName: '$i',
      birthDate: DateTime(2005, 1, i),
    );
  }
}

Future<void> demonstrateFutures() async {
  print('\n--- Futures ---');

  final stopwatch = Stopwatch()..start();

  for (final id in ['S001', 'S002', 'S003']) {
    print(await fetchStudentData(id));
  }

  stopwatch.stop();
  print('Sequential time: ${stopwatch.elapsedMilliseconds} ms');

  stopwatch.reset();
  stopwatch.start();

  final results = await Future.wait([
    fetchStudentData('S001'),
    fetchStudentData('S002'),
    fetchStudentData('S003'),
  ]);

  results.forEach(print);

  stopwatch.stop();
  print('Concurrent time: ${stopwatch.elapsedMilliseconds} ms');

  try {
    await fetchStudentData('S004').timeout(
      const Duration(milliseconds: 500),
    );
  } catch (e) {
    print('Handled timeout: $e');
  }
}

Future<void> demonstrateStreams() async {
  print('\n--- Streams ---');

  await studentStream()
      .map((student) => student.fullName)
      .listen((name) => print('Received: $name'))
      .asFuture<void>();
}

Future<void> demonstrateFileOperations() async {
  print('\n--- Async File Operations ---');

  final students = await studentStream().toList();

  await saveStudentsToFile(students, 'data/students.json');
  print('JSON file saved');

  final loaded = await loadStudentsFromFile('data/students.json');
  print('Loaded students: ${loaded.length}');

  final report = {
    'totalStudents': loaded.length,
    'students': loaded.map((s) => s.fullName).toList(),
  };

  await File('reports/async_report.json').writeAsString(
    const JsonEncoder.withIndent('  ').convert(report),
  );

  print('Report saved: reports/async_report.json');
}