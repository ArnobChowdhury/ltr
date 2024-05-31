import 'package:hive_flutter/adapters.dart';
import "package:ltr/models/subject.dart";

class HiveService {
  static const String _subjectsBoxName = 'subjects';

  static Future<void> init() async {
    await Hive.initFlutter("ltr");
    Hive.registerAdapter(SubjectAdapter());
    await Hive.openBox<Subject>(_subjectsBoxName);
  }

  Box<Subject> get subjectsBox => Hive.box<Subject>(_subjectsBoxName);

  List<Subject> getSubjects() {
    return subjectsBox.values.toList();
  }

  Future<void> addSubject(String name, String color) async {
    final subject = Subject(name, color);
    await subjectsBox.add(subject);
  }

  Future<void> updateSubject(int index, String name, String color) async {
    final subject = Subject(name, color);
    await subjectsBox.putAt(index, subject);
  }

  Future<void> deleteSubject(int index) async {
    await subjectsBox.deleteAt(index);
  }
}
