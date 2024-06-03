import 'package:hive_flutter/adapters.dart';
import "package:ltr/models/subject/subject.dart";
import "package:ltr/models/folder/folder.dart";
import "package:uuid/uuid.dart";

class HiveService {
  static const String _subjectsBoxName = 'subjects';
  static const String _folderBoxName = 'folder';

  static Future<void> init() async {
    await Hive.initFlutter("ltr");
    Hive.registerAdapter(SubjectAdapter());
    Hive.registerAdapter(FolderAdapter());

    await Hive.openBox<Subject>(_subjectsBoxName);
    await Hive.openBox<Folder>(_folderBoxName);
  }

  Box<Subject> get subjectsBox => Hive.box<Subject>(_subjectsBoxName);
  Box<Folder> get foldersBox => Hive.box<Folder>(_folderBoxName);

  List<Subject> getSubjects() {
    return subjectsBox.values.toList();
  }

  Subject? getOneSubject(int index) {
    return subjectsBox.getAt(index);
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

  List<Folder> getFolders(int subjectIndex) {
    Subject? subject = subjectsBox.getAt(subjectIndex);
    // should I throw an error here?
    if (subject == null) return [];
    return foldersBox.values
        .where((folder) => folder.subject == subject)
        .toList();
  }

  Future<void> addFolder(
      {required String name,
      required Subject subject,
      List<Folder> children = const []}) async {
    Uuid uuidObject = const Uuid();
    String uuid = uuidObject.v4();

    Folder newFolder =
        Folder(name: name, uuid: uuid, subject: subject, children: children);
    await foldersBox.add(newFolder);
  }
}
