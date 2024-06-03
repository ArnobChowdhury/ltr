import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'subject.g.dart';

@HiveType(typeId: 0)
class Subject extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String color;

  @HiveField(2)
  String id;

  Subject(this.name, this.color) : id = const Uuid().v4();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subject && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
