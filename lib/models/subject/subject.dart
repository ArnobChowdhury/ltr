import 'package:hive/hive.dart';

part 'subject.g.dart';

@HiveType(typeId: 0)
class Subject extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String color;

  Subject(this.name, this.color);
}
