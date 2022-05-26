import 'package:hive/hive.dart';
import 'package:weather/domain/entity/task.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group {
  @HiveField(0)
  late String name;

  @HiveField(1)
  HiveList<Task>? tasks;

  Group({required this.name});

  void addTask(Box<Task> box, Task task) {
    tasks ??= HiveList(box);
    tasks?.add(task);
    // save();
  }
}
