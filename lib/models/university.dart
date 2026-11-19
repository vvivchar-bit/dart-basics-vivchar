import 'student.dart';
import 'course.dart';

abstract class Person {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  String get fullName => '$firstName $lastName';

  int get age {
    final now = DateTime.now();
    int years = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month &&
            now.day < birthDate.day)) {
      years--;
    }

    return years;
  }

  String get role;
}

class Professor extends Person {
  final String department;
  final List<String> taughtCourses;
  final double salary;

  Professor({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.birthDate,
    required this.department,
    required this.salary,
    List<String>? taughtCourses,
  }) : taughtCourses = taughtCourses ?? [];

  @override
  String get role => 'Professor';

  void assignCourse(String courseId) {
    if (!taughtCourses.contains(courseId)) {
      taughtCourses.add(courseId);
    }
  }

  @override
  String toString() {
    return '$fullName | $role | $department';
  }
}
  class University {
  final String name;
  final List<Student> students;
  final List<Professor> professors;
  final List<Course> courses;

  University({
  required this.name,
  List<Student>? students,
  List<Professor>? professors,
  List<Course>? courses,
  }) : students = students ?? [],
  professors = professors ?? [],
  courses = courses ?? [];

  void addStudent(Student student) {
  if (findStudentById(student.id) == null) {
  students.add(student);
  }
  }

  void removeStudent(String studentId) {
  students.removeWhere((student) => student.id == studentId);
  }

  Student? findStudentById(String id) {
  for (final student in students) {
  if (student.id == id) {
  return student;
  }
  }
  return null;
  }

  List<Student> getStudentsByCourse(String courseId) {
  return students
      .where((student) => student.enrolledCourses.contains(courseId))
      .toList();
  }

  List<Course> getAvailableCoursesForStudent(String studentId) {
  final student = findStudentById(studentId);

  if (student == null) return [];

  return courses.where((course) =>
  course.canStudentEnroll(student) &&
  !student.enrolledCourses.contains(course.id)).toList();
  }

  Map<String, dynamic> generateStatistics() {
  final averageGpa = students.isEmpty
  ? 0.0
      : students.map((s) => s.gpa).reduce((a, b) => a + b)
  / students.length;

  return {
  'University': name,
  'Students': students.length,
  'Professors': professors.length,
  'Courses': courses.length,
  'Average GPA': averageGpa,
  };
  }
  }
