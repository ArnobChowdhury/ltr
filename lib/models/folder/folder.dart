import 'package:hive/hive.dart';
import 'package:ltr/models/subject/subject.dart';

part 'folder.g.dart';

@HiveType(typeId: 0)
class Folder extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String uuid;

  // Store the owner as a Hive object
  @HiveField(2)
  Subject? subject;
  // Subject(this.name);

  @HiveField(3)
  Folder? parentFolder;
}
