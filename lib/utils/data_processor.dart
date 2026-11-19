import '../models/student.dart';
import '../models/university.dart';

class DataProcessor {
  static List<int> filterEvenNumbers(List<int> numbers) {
    return numbers.where((n) => n.isEven).toList();
  }

  static Map<String, int> countWords(String text) {
    final result = <String, int>{};

    if (text.trim().isEmpty) return result;

    for (final word in text.toLowerCase().trim().split(RegExp(r'\s+'))) {
      result[word] = (result[word] ?? 0) + 1;
    }

    return result;
  }

  static List<Map<String, dynamic>> sortStudentsByGPA(List<Student> students) {
    final sorted = [...students];
    sorted.sort((a, b) => b.gpa.compareTo(a.gpa));

    return sorted.map((s) => {'name': s.fullName, 'gpa': s.gpa}).toList();
  }

  static Set<String> findCommonCourses(List<Student> students) {
    if (students.isEmpty) return {};

    var common = students.first.enrolledCourses.toSet();

    for (final student in students.skip(1)) {
      common = common.intersection(student.enrolledCourses.toSet());
    }

    return common;
  }

  static Map<String, List<Student>> groupStudentsByYear(
    List<Student> students,
  ) {
    final result = <String, List<Student>>{};

    for (final student in students) {
      final year = student.birthDate.year.toString();
      result.putIfAbsent(year, () => []).add(student);
    }

    return result;
  }

  static Map<String, double> calculateAverageGradesByCourse(
    List<Student> students,
  ) {
    final grades = <String, List<double>>{};

    for (final student in students) {
      student.grades.forEach((course, grade) {
        grades.putIfAbsent(course, () => []).add(grade);
      });
    }

    return grades.map(
      (course, values) =>
          MapEntry(course, values.reduce((a, b) => a + b) / values.length),
    );
  }

  static List<Map<String, dynamic>> generateReport(University university) {
    return university.courses
        .map(
          (course) => {
            'course': course.name,
            'students': university.getStudentsByCourse(course.id).length,
            'averageGrade':
                calculateAverageGradesByCourse(
                  university.students,
                )[course.id] ??
                0,
          },
        )
        .toList();
  }
}
