import 'package:dart_basics_vivchar/models/student.dart';
import 'package:dart_basics_vivchar/models/course.dart';
import 'package:dart_basics_vivchar/models/university.dart';

void main() {
  print('=== University Management System Demo ===');

  runUniversityDemo();
}

void runUniversityDemo() {
  final university = University(name: 'ISTU');

  final student1 = Student(
    id: 'S001',
    firstName: 'Vadim',
    lastName: 'Vivchar',
    birthDate: DateTime(2000, 5, 15),
  );

  final student2 = Student(
    id: 'S002',
    firstName: 'Ivan',
    lastName: 'Petrenko',
    birthDate: DateTime(2005, 8, 20),
  );

  final professor = Professor(
    id: 'P001',
    firstName: 'Oleksandr',
    lastName: 'Kovalenko',
    birthDate: DateTime(1980, 3, 10),
    department: 'Computer Science',
    salary: 25000,
  );

  final dart = Course(
    id: 'C001',
    name: 'Dart Programming',
    description: 'Dart language basics',
    credits: 4,
    instructor: professor.fullName,
  );

  final flutter = Course(
    id: 'C002',
    name: 'Flutter Development',
    description: 'Mobile applications',
    credits: 5,
    instructor: professor.fullName,
    prerequisites: ['C001'],
  );

  university.addStudent(student1);
  university.addStudent(student2);
  university.professors.add(professor);
  university.courses.addAll([dart, flutter]);

  professor.assignCourse(dart.id);
  professor.assignCourse(flutter.id);

  student1.enrollInCourse(dart.id);
  student2.enrollInCourse(dart.id);

  student1.addGrade(dart.id, 95);
  student2.addGrade(dart.id, 85);

  if (flutter.canStudentEnroll(student1)) {
    student1.enrollInCourse(flutter.id);
    student1.addGrade(flutter.id, 90);
  }

  print('\n--- Students ---');
  university.students.forEach(print);

  print('\n--- Professors ---');
  university.professors.forEach(print);

  print('\n--- Courses ---');
  university.courses.forEach(print);

  print('\n--- Student Search ---');
  print(university.findStudentById('S001'));

  print('\n--- Available Courses ---');
  print(university.getAvailableCoursesForStudent('S002'));

  print('\n--- Statistics ---');
  university.generateStatistics().forEach((key, value) {
    print('$key: $value');
  });

  print('\n--- JSON ---');
  print(student1.toJson());

  print('\n--- Remove Student ---');
  university.removeStudent('S002');
  print('Remaining students: ${university.students.length}');
}
