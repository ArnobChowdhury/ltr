import 'package:hive/hive.dart';
import 'package:ltr/models/subject/subject.dart';
import 'package:uuid/uuid.dart';

part 'folder.g.dart';

@HiveType(typeId: 1)
class Folder extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String id;

  // Store the owner as a Hive object
  @HiveField(2)
  Subject? subject;

  @HiveField(3)
  List<Folder> children;

  Folder({required this.name, this.subject, this.children = const []})
      : id = const Uuid().v4();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Folder && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
