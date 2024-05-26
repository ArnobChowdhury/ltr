import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import "package:ltr/models/subject.dart";

class HiveService {
  static const String _subjectsBoxName = 'subjects';

  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
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

  Future<void> deleteSubject(int index) async {
    await subjectsBox.deleteAt(index);
  }
}
