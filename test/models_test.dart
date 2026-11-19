import 'package:test/test.dart';
import '../lib/models/student.dart';
import '../lib/models/course.dart';
import '../lib/models/university.dart';

void main() {
  late Student student;

  setUp(() {
    student = Student(
      id: 'S001',
      firstName: 'Test',
      lastName: 'Student',
      birthDate: DateTime(2005, 1, 1),
    );
  });

  test('Student full name', () {
    expect(student.fullName, 'Test Student');
  });

  test('Student GPA calculation', () {
    student.addGrade('C001', 90);
    student.addGrade('C002', 80);
    expect(student.gpa, 85);
  });

  test('Duplicate course prevention', () {
    student.enrollInCourse('C001');
    student.enrollInCourse('C001');
    expect(student.enrolledCourses.length, 1);
  });

  test('Invalid grade validation', () {
    expect(
          () => student.addGrade('C001', 110),
      throwsArgumentError,
    );
  });

  test('Passed courses', () {
    student.addGrade('C001', 90);
    student.addGrade('C002', 50);
    expect(student.getPassedCourses(), ['C001']);
  });

  test('JSON conversion', () {
    final restored = Student.fromJson(student.toJson());
    expect(restored.fullName, student.fullName);
  });

  test('Course prerequisites', () {
    final course = Course(
      id: 'C002',
      name: 'Flutter',
      description: 'Mobile development',
      credits: 5,
      instructor: 'Professor',
      prerequisites: ['C001'],
    );

    expect(course.canStudentEnroll(student), isFalse);

    student.addGrade('C001', 90);

    expect(course.canStudentEnroll(student), isTrue);
  });

  test('University student management', () {
    final university = University(name: 'ISTU');

    university.addStudent(student);
    expect(university.students.length, 1);
    expect(university.findStudentById('S001'), student);

    university.removeStudent('S001');
    expect(university.students, isEmpty);
  });
}